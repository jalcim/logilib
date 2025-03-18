cmake_minimum_required(VERSION 3.23)
project(logilib)

# Options pour activer/désactiver les modules
option(ENABLE_SRC "Activer src/" ON)
option(ENABLE_SRC_PRIMITIVE "Activer src/primitive" ON)
option(ENABLE_SRC_PRIMITIVE_GATE "Activer src/primitive/gate" ON)

option(ENABLE_COSIM "Activer cosim/" ON)
option(ENABLE_COSIM_PRIMITIVE "Activer cosim/primitive" ON)
option(ENABLE_COSIM_PRIMITIVE_GATE "Activer cosim/primitive/gate" ON)

# Configuration globale
option(ENABLE_VCD "Enable VCD trace file generation" ON)
option(STATIC_BUILD "Compiles into one binary with no dynamic dependencies" OFF)
set(LOG_LEVEL "warning" CACHE STRING "Set the log level")
set(MAX_WAYS "8" CACHE STRING "Max number of gates ways generated")
set(VERILATOR_TIME_STEP "1000" CACHE STRING "Time between each verilator evaluations")

# Gestion statique/dynamique des bibliothèques Boost
set(Boost_USE_STATIC_LIBS OFF)
set(Boost_USE_DEBUG_LIBS OFF)
set(Boost_USE_RELEASE_LIBS ON)
set(Boost_USE_MULTITHREADED ON)
set(Boost_USE_STATIC_RUNTIME OFF)

if (STATIC_BUILD)
    set(CMAKE_FIND_LIBRARY_SUFFIXES ".a")
    set(BUILD_SHARED_LIBS OFF)
    set(CMAKE_EXE_LINKER_FLAGS "-static")
    set(Boost_USE_STATIC_LIBS on)
endif()

# Dépendances
find_package(Boost 1.74.0 REQUIRED COMPONENTS log log_setup system unit_test_framework)
find_package(verilator REQUIRED HINTS $ENV{VERILATOR_ROOT} ${VERILATOR_ROOT})
#verilator_generate_key(PROTECT_KEY)

# Ajout conditionnel des sous-dossiers
if (ENABLE_SRC)
    add_subdirectory(src)
endif()

if (ENABLE_COSIM)
    add_subdirectory(cosim)
endif()
