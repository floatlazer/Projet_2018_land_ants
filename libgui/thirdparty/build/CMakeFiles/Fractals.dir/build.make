# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 2.8

#=============================================================================
# Special targets provided by cmake.

# Disable implicit rules so canonical targets will work.
.SUFFIXES:

# Remove some rules from gmake that .SUFFIXES does not remove.
SUFFIXES =

.SUFFIXES: .hpux_make_needs_suffix_list

# Suppress display of executed commands.
$(VERBOSE).SILENT:

# A target that is always out of date.
cmake_force:
.PHONY : cmake_force

#=============================================================================
# Set environment variables for the build.

# The shell in which to execute make rules.
SHELL = /bin/sh

# The CMake executable.
CMAKE_COMMAND = /usr/bin/cmake

# The command to remove a file.
RM = /usr/bin/cmake -E remove -f

# Escaping for special characters.
EQUALS = =

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = /home/x/xuazhang/2A/IN203/Projet_2018_land_ants/libgui/thirdparty/freeglut-3.0.0

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /home/x/xuazhang/2A/IN203/Projet_2018_land_ants/libgui/thirdparty/build

# Include any dependencies generated for this target.
include CMakeFiles/Fractals.dir/depend.make

# Include the progress variables for this target.
include CMakeFiles/Fractals.dir/progress.make

# Include the compile flags for this target's objects.
include CMakeFiles/Fractals.dir/flags.make

CMakeFiles/Fractals.dir/progs/demos/Fractals/fractals.c.o: CMakeFiles/Fractals.dir/flags.make
CMakeFiles/Fractals.dir/progs/demos/Fractals/fractals.c.o: /home/x/xuazhang/2A/IN203/Projet_2018_land_ants/libgui/thirdparty/freeglut-3.0.0/progs/demos/Fractals/fractals.c
	$(CMAKE_COMMAND) -E cmake_progress_report /home/x/xuazhang/2A/IN203/Projet_2018_land_ants/libgui/thirdparty/build/CMakeFiles $(CMAKE_PROGRESS_1)
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Building C object CMakeFiles/Fractals.dir/progs/demos/Fractals/fractals.c.o"
	/usr/bin/gcc  $(C_DEFINES) $(C_FLAGS) -o CMakeFiles/Fractals.dir/progs/demos/Fractals/fractals.c.o   -c /home/x/xuazhang/2A/IN203/Projet_2018_land_ants/libgui/thirdparty/freeglut-3.0.0/progs/demos/Fractals/fractals.c

CMakeFiles/Fractals.dir/progs/demos/Fractals/fractals.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing C source to CMakeFiles/Fractals.dir/progs/demos/Fractals/fractals.c.i"
	/usr/bin/gcc  $(C_DEFINES) $(C_FLAGS) -E /home/x/xuazhang/2A/IN203/Projet_2018_land_ants/libgui/thirdparty/freeglut-3.0.0/progs/demos/Fractals/fractals.c > CMakeFiles/Fractals.dir/progs/demos/Fractals/fractals.c.i

CMakeFiles/Fractals.dir/progs/demos/Fractals/fractals.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling C source to assembly CMakeFiles/Fractals.dir/progs/demos/Fractals/fractals.c.s"
	/usr/bin/gcc  $(C_DEFINES) $(C_FLAGS) -S /home/x/xuazhang/2A/IN203/Projet_2018_land_ants/libgui/thirdparty/freeglut-3.0.0/progs/demos/Fractals/fractals.c -o CMakeFiles/Fractals.dir/progs/demos/Fractals/fractals.c.s

CMakeFiles/Fractals.dir/progs/demos/Fractals/fractals.c.o.requires:
.PHONY : CMakeFiles/Fractals.dir/progs/demos/Fractals/fractals.c.o.requires

CMakeFiles/Fractals.dir/progs/demos/Fractals/fractals.c.o.provides: CMakeFiles/Fractals.dir/progs/demos/Fractals/fractals.c.o.requires
	$(MAKE) -f CMakeFiles/Fractals.dir/build.make CMakeFiles/Fractals.dir/progs/demos/Fractals/fractals.c.o.provides.build
.PHONY : CMakeFiles/Fractals.dir/progs/demos/Fractals/fractals.c.o.provides

CMakeFiles/Fractals.dir/progs/demos/Fractals/fractals.c.o.provides.build: CMakeFiles/Fractals.dir/progs/demos/Fractals/fractals.c.o

# Object files for target Fractals
Fractals_OBJECTS = \
"CMakeFiles/Fractals.dir/progs/demos/Fractals/fractals.c.o"

# External object files for target Fractals
Fractals_EXTERNAL_OBJECTS =

bin/Fractals: CMakeFiles/Fractals.dir/progs/demos/Fractals/fractals.c.o
bin/Fractals: CMakeFiles/Fractals.dir/build.make
bin/Fractals: /usr/lib/x86_64-linux-gnu/libGLU.so
bin/Fractals: /usr/lib/x86_64-linux-gnu/libGL.so
bin/Fractals: /usr/lib/x86_64-linux-gnu/libSM.so
bin/Fractals: /usr/lib/x86_64-linux-gnu/libICE.so
bin/Fractals: /usr/lib/x86_64-linux-gnu/libX11.so
bin/Fractals: /usr/lib/x86_64-linux-gnu/libXext.so
bin/Fractals: /usr/lib/x86_64-linux-gnu/libXrandr.so
bin/Fractals: /usr/lib/x86_64-linux-gnu/libXxf86vm.so
bin/Fractals: /usr/lib/x86_64-linux-gnu/libXi.so
bin/Fractals: lib/libglut.so.3.10.0
bin/Fractals: /usr/lib/x86_64-linux-gnu/libGL.so
bin/Fractals: /usr/lib/x86_64-linux-gnu/libSM.so
bin/Fractals: /usr/lib/x86_64-linux-gnu/libICE.so
bin/Fractals: /usr/lib/x86_64-linux-gnu/libX11.so
bin/Fractals: /usr/lib/x86_64-linux-gnu/libXext.so
bin/Fractals: /usr/lib/x86_64-linux-gnu/libXrandr.so
bin/Fractals: /usr/lib/x86_64-linux-gnu/libXxf86vm.so
bin/Fractals: /usr/lib/x86_64-linux-gnu/libXi.so
bin/Fractals: CMakeFiles/Fractals.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --red --bold "Linking C executable bin/Fractals"
	$(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/Fractals.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
CMakeFiles/Fractals.dir/build: bin/Fractals
.PHONY : CMakeFiles/Fractals.dir/build

CMakeFiles/Fractals.dir/requires: CMakeFiles/Fractals.dir/progs/demos/Fractals/fractals.c.o.requires
.PHONY : CMakeFiles/Fractals.dir/requires

CMakeFiles/Fractals.dir/clean:
	$(CMAKE_COMMAND) -P CMakeFiles/Fractals.dir/cmake_clean.cmake
.PHONY : CMakeFiles/Fractals.dir/clean

CMakeFiles/Fractals.dir/depend:
	cd /home/x/xuazhang/2A/IN203/Projet_2018_land_ants/libgui/thirdparty/build && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/x/xuazhang/2A/IN203/Projet_2018_land_ants/libgui/thirdparty/freeglut-3.0.0 /home/x/xuazhang/2A/IN203/Projet_2018_land_ants/libgui/thirdparty/freeglut-3.0.0 /home/x/xuazhang/2A/IN203/Projet_2018_land_ants/libgui/thirdparty/build /home/x/xuazhang/2A/IN203/Projet_2018_land_ants/libgui/thirdparty/build /home/x/xuazhang/2A/IN203/Projet_2018_land_ants/libgui/thirdparty/build/CMakeFiles/Fractals.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : CMakeFiles/Fractals.dir/depend

