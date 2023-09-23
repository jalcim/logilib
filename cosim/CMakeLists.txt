cmake_minimum_required(VERSION 3.18)
project(Vmain C CXX)

find_package(verilator HINTS $ENV{VERILATOR_ROOT})
if (NOT verilator_FOUND)
  message(FATAL_ERROR "Verilator was not found. Either install it, or set the VERILATOR_ROOT environment variable")
endif()

# set(CMAKE_FIND_LIBRARY_SUFFIXES ".a")
# set(BUILD_SHARED_LIBS OFF)
# set(CMAKE_EXE_LINKER_FLAGS "-static")

# set(CMAKE_BUILD_TYPE Debug)
# set(CMAKE_CPPFLAGS "${CMAKE_CPPFLAGS} -DVL_DEBUG")

add_subdirectory(primitive)
add_subdirectory(tools)

add_compile_options(-std=c++11)

add_executable(${PROJECT_NAME})

target_link_libraries(${PROJECT_NAME} LINK_PUBLIC Cosim_tools Cosim_primitives)

target_sources(${PROJECT_NAME} PRIVATE ./main.cpp)

# target_include_directories(${PROJECT_NAME}
#   PRIVATE
#       # where the library itself will look for its internal headers
#   PUBLIC
#       # where top-level project will look for the library's public headers
#       $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}>
#       # where external projects will look for the library's public headers
#       $<INSTALL_INTERFACE:${CMAKE_INSTALL_INCLUDEDIR}>
# )


