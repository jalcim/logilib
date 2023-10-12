cmake_minimum_required(VERSION 3.18)
project(Cosim_primitives C CXX)

include(environment)

INIT_ENVIRONMENT()

add_subdirectory(gate)
#add_subdirectory(parallel_gate)
#add_subdirectory(serial_gate)

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



