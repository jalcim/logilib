cmake_minimum_required(VERSION 3.18)
project(Vmain C CXX)


find_package(verilator HINTS $ENV{VERILATOR_ROOT})
if (NOT verilator_FOUND)
  message(FATAL_ERROR "Verilator was not found. Either install it, or set the VERILATOR_ROOT environment variable")
endif()

set(Boost_USE_STATIC_LIBS        OFF)  # only find static libs
set(Boost_USE_DEBUG_LIBS         OFF) # ignore debug libs and
set(Boost_USE_RELEASE_LIBS       ON)  # only find release libs
set(Boost_USE_MULTITHREADED      ON)
set(Boost_USE_STATIC_RUNTIME    OFF)


set(VERILATOR_INCLUDES $ENV{VERILATOR_ROOT}/include/)

if (DEFINED ENV{COMPILE_STATIC})
  set(CMAKE_FIND_LIBRARY_SUFFIXES ".a")
  set(BUILD_SHARED_LIBS OFF)
  set(CMAKE_EXE_LINKER_FLAGS "-static")
  set(Boost_USE_STATIC_LIBS on)  # only find static libs
else()
add_compile_options(-DBOOST_LOG_DYN_LINK)
endif()


find_package(Boost 1.74.0 COMPONENTS log log_setup)

if(NOT Boost_FOUND)
  message(FATAL_ERROR "Boost was not found")
endif()

include_directories(${Boost_INCLUDE_DIRS})

if(DEFINED ENV{MAX_WAYS})
  set(MAX_WAYS $ENV{MAX_WAYS})
endif()

if(DEFINED ENV{LOG_LEVEL})
add_compile_definitions(LOG_LEVEL=$ENV{LOG_LEVEL})
endif()

add_subdirectory(primitive)

add_compile_options(-std=c++11)

add_executable(${PROJECT_NAME})

target_link_libraries(${PROJECT_NAME} LINK_PUBLIC Cosim_primitives ${Boost_LIBRARIES})

target_sources(${PROJECT_NAME} PRIVATE ./main.cpp)
