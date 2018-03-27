#include <vector>
#include <iostream>
#include <random>
#include "fractal_land.hpp"
#include "ant.hpp"
#include "pheronome.hpp"
# include "gui/context.hpp"
# include "gui/colors.hpp"
# include "gui/point.hpp"
# include "gui/segment.hpp"
# include "gui/triangle.hpp"
# include "gui/quad.hpp"
# include "gui/event_manager.hpp"
# include "display.hpp"
# include <omp.h>
# include <mpi.h>
#include <chrono>

void advance_time( const fractal_land& land, pheronome& phen,
                   const position_t& pos_nest, const position_t& pos_food,
                   std::vector<ant>& ants, std::size_t& cpteur, size_t begin, size_t end)
{
    # pragma omp parallel for
    for ( size_t i = begin; i < end; ++i )
        ants[i].advance(phen, land, pos_food, pos_nest, cpteur);
    phen.do_evaporation();
    phen.update();
}

int main(int nargs, char* argv[])
{
    // Init MPI begin
    MPI_Init( &nargs, &argv );
    MPI_Comm globComm;
    MPI_Comm_dup(MPI_COMM_WORLD, &globComm);
    int nbp;
    MPI_Comm_size(globComm, &nbp);
    int rank;
    MPI_Comm_rank(globComm, &rank);
    // Init common variables
    const int nb_ants = 5000; // Nombre de fourmis
    const double eps = 0.8;  // Coefficient d'exploration
    const double alpha=0.7; // Coefficient de chaos
    //const double beta=0.9999; // Coefficient d'évaporation
    const double beta=0.999; // Coefficient d'évaporation
    // Location du nid
    position_t pos_nest{256,256};
    //const int i_nest = 256, j_nest = 256;
    // Location de la nourriture
    position_t pos_food{500,500};
    //const int i_food = 500, j_food = 500;
    // Génération du territoire 512 x 512 ( 2*(2^8) par direction )
    fractal_land land(8,2,1.,1024);
    double max_val = 0.0;
    double min_val = 0.0;
    for ( fractal_land::dim_t i = 0; i < land.dimensions(); ++i )
        for ( fractal_land::dim_t j = 0; j < land.dimensions(); ++j ) {
            max_val = std::max(max_val, land(i,j));
            min_val = std::min(min_val, land(i,j));
        }
    double delta = max_val - min_val;
    /* On redimensionne les valeurs de fractal_land de sorte que les valeurs
    soient comprises entre zéro et un */
    for ( fractal_land::dim_t i = 0; i < land.dimensions(); ++i )
        for ( fractal_land::dim_t j = 0; j < land.dimensions(); ++j )  {
            land(i,j) = (land(i,j)-min_val)/delta;
        }

    size_t real_nb = nb_ants / (nbp - 1) * (nbp - 1);
    MPI_Comm computeCom;
    // Graphic
    if(rank == 0)
    {
        MPI_Comm_split(globComm, MPI_UNDEFINED, 0, &computeCom);
        std::vector<ant> ants(real_nb);
        //ants.reserve(nb_ants);
        pheronome phen(land.dimensions(), pos_food, pos_nest, alpha, beta);
        size_t food_quantity = 0;

        gui::context graphic_context(nargs, argv);
        gui::window& win =  graphic_context.new_window(2*land.dimensions()+10,land.dimensions()+266);
        display_t displayer( land, phen, pos_nest, pos_food, ants, win );
        gui::event_manager manager;
        manager.on_key_event(int('q'), [] (int code) { exit(0); });
        manager.on_display([&] { displayer.display(food_quantity); win.blit(); });
        manager.on_idle([&] () {
            // Receive ants, phen and food_quantity
            ants.resize(0);
            size_t ants_pos[nb_ants*2] = {1};
            MPI_Recv(ants_pos, real_nb*2, MPI_UNSIGNED, MPI_ANY_SOURCE, 0, globComm, NULL);
            MPI_Recv(&phen(0,0), 2*land.dimensions()*land.dimensions(), MPI_DOUBLE, MPI_ANY_SOURCE, 1, globComm, NULL);
            MPI_Recv(&food_quantity, 1, MPI_UNSIGNED, MPI_ANY_SOURCE, 2, globComm, NULL);
            // Update ants
            for(int i = 0; i < real_nb; i++)
                ants.emplace_back(std::pair<size_t, size_t>(ants_pos[i*2], ants_pos[i*2+1]));
            displayer.display(food_quantity);
            win.blit();
        });
        manager.loop();
    }
    // Computation
    else
    {
        MPI_Comm_split(globComm, 0, rank, &computeCom);
        // Définition du coefficient d'exploration de toutes les fourmis.
        ant::set_exploration_coef(eps);
        // On va créer des fourmis un peu partout sur la carte :
        std::vector<ant> ants;
        ants.reserve(nb_ants);
        std::random_device                       rd;  // Will be used to obtain a seed for the random number engine
        std::mt19937                             gen( rd( ) );  // Standard mersenne_twister_engine seeded with rd()
        std::uniform_int_distribution<size_t>    ant_pos( 0, land.dimensions()-1 );
        for ( size_t i = 0; i < nb_ants; ++i )
            ants.push_back({{ant_pos(gen),ant_pos(gen)}});
        // On crée toutes les fourmis dans la fourmilière.
        pheronome phen(land.dimensions(), pos_food, pos_nest, alpha, beta);

        // Compteur de la quantité de nourriture apportée au nid par les fourmis
        size_t food_quantity = 0;
        size_t food_quantity_send;

        while(1)
        {
            double duration;
            auto start_time = std::chrono::high_resolution_clock::now();
            size_t begin = ants.size() / (nbp - 1) * (rank - 1);
            size_t end = ants.size() / (nbp - 1) * rank;
            if(end >= ants.size()) end = ants.size();
            advance_time(land, phen, pos_nest, pos_food, ants, food_quantity, begin, end);
            // Send ants pos
            size_t ants_pos[(end-begin)*2];
            size_t ants_pos_send[real_nb * 2];
            for(auto i = begin; i < end; i++)
            {
                ants_pos[2*(i-begin)] = ants[i].get_position().first;
                ants_pos[2*(i-begin) + 1] = ants[i].get_position().second;
            }
            // Gather ants positions
            MPI_Gather(&ants_pos[0], (end - begin)*2, MPI_UNSIGNED, &ants_pos_send[0], (end - begin)*2, MPI_UNSIGNED, 0, computeCom);
            // Reduce and broadcast pheromone
            MPI_Allreduce(MPI_IN_PLACE, &phen(0,0), 2*land.dimensions()*land.dimensions(), MPI_DOUBLE, MPI_MAX, computeCom);
            // Sum food_quantity
            MPI_Reduce(&food_quantity, &food_quantity_send, 1, MPI_UNSIGNED, MPI_SUM, 0, computeCom);
            // Send
            if(rank == 1)
            {
                // Send pos
                MPI_Send(&ants_pos_send[0], real_nb * 2, MPI_UNSIGNED, 0, 0, globComm);
                // Send phen
                MPI_Send(&phen(0, 0), 2*land.dimensions()*land.dimensions(), MPI_DOUBLE, 0, 1, globComm);
                // Send food_quantity
                MPI_Send(&food_quantity_send, 1, MPI_UNSIGNED, 0, 2, globComm);
            }
            auto end_time = std::chrono::high_resolution_clock::now();
            duration = std::chrono::duration<double>(end_time - start_time).count();
            std::cout << "Process "<<rank<<" ants ["<<begin<<", "<<end<<"] "<<
            "duration: "<<duration<<"s"<<std::endl;
        }
    }


    MPI_Finalize(); // Clean up
    return 0;
}
