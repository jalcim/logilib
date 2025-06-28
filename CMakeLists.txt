cmake_minimum_required(VERSION 3.28)
cmake_policy(SET CMP0167 OLD)  # Utilise FindBoost obsolète mais encore dispo
project(logilib)

if(NOT EXISTS "${CMAKE_SOURCE_DIR}/build_config.cmake")
  message(FATAL_ERROR "File build_config.cmake not found")
endif()
include("${CMAKE_SOURCE_DIR}/build_config.cmake" OPTIONAL)

if (STATIC_BUILD)
    set(CMAKE_FIND_LIBRARY_SUFFIXES ".a")
    set(BUILD_SHARED_LIBS OFF)
    set(CMAKE_EXE_LINKER_FLAGS "-static -g -fsanitize=address -fno-omit-frame-pointe")
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
  file(MAKE_DIRECTORY ${CMAKE_BINARY_DIR}/signal)
  add_subdirectory(cosim)
endif()
