cmake_minimum_required(VERSION 3.18)
project(Cosim_arithm C CXX)

include(environment)

INIT_ENVIRONMENT()

add_subdirectory(addx)
add_subdirectory(add_sub)

add_library(${PROJECT_NAME} STATIC)

# target_link_libraries(${PROJECT_NAME} LINK_PUBLIC Cosim_addx Boost::log)
target_link_libraries(${PROJECT_NAME} LINK_PUBLIC Cosim_addx Cosim_add_sub Boost::log)

target_sources(${PROJECT_NAME} PRIVATE ./arithm.cpp)

target_include_directories(${PROJECT_NAME}
  PRIVATE
    ${CMAKE_CURRENT_SOURCE_DIR}/addx
    ${CMAKE_CURRENT_SOURCE_DIR}/add_sub
  PUBLIC
    # where top-level project will look for the library's public headers
    $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}>
    # where external projects will look for the library's public headers
    $<INSTALL_INTERFACE:${CMAKE_INSTALL_INCLUDEDIR}>
)



