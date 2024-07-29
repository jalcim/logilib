cmake_minimum_required(VERSION 3.18)
project(verif_arithm C)
add_library(${PROJECT_NAME} STATIC ./add_sub.c)
set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -Wall -Werror -std=c99")

target_include_directories(${PROJECT_NAME}
  PUBLIC
    ${CMAKE_CURRENT_SOURCE_DIR}
    # where top-level project will look for the library's public headers
    $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/>
    # where external projects will look for the library's public headers
    $<INSTALL_INTERFACE:${CMAKE_INSTALL_INCLUDEDIR}>
)


