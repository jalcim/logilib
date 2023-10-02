cmake_minimum_required(VERSION 3.18)
project(Cosim_primitives C CXX)

find_package(verilator HINTS $ENV{VERILATOR_ROOT} ${VERILATOR_ROOT})
if (NOT verilator_FOUND)
  message(FATAL_ERROR "Verilator was not found. Either install it, or set the VERILATOR_ROOT environment variable")
endif()

add_subdirectory(gate)
#add_subdirectory(parallel_gate)
#add_subdirectory(serial_gate)

add_compile_options(-std=c++11)

add_library(${PROJECT_NAME} STATIC)

target_link_libraries(${PROJECT_NAME} LINK_PUBLIC Cosim_gates Boost::log)

target_sources(${PROJECT_NAME} PRIVATE ./primitive.cpp)

target_include_directories(${PROJECT_NAME}
  PRIVATE
    ${CMAKE_CURRENT_SOURCE_DIR}/gate
  PUBLIC
    # where top-level project will look for the library's public headers
    $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}>
    # where external projects will look for the library's public headers
    $<INSTALL_INTERFACE:${CMAKE_INSTALL_INCLUDEDIR}>
)



