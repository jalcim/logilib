cmake_minimum_required(VERSION 3.18)
project(Cosim_tools C CXX)

find_package(verilator HINTS $ENV{VERILATOR_ROOT} ${VERILATOR_ROOT})
if (NOT verilator_FOUND)
  message(FATAL_ERROR "Verilator was not found. Either install it, or set the VERILATOR_ROOT environment variable")
endif()

set(COSIM_TOOLS_INCLUDES ${CMAKE_CURRENT_SOURCE_DIR}/logs.h)
set(COSIM_TOOLS_SRC ${CMAKE_CURRENT_SOURCE_DIR}/logs.cpp)

add_library(${PROJECT_NAME} STATIC)

target_sources(${PROJECT_NAME} PRIVATE ${COSIM_TOOLS_SRC})

target_include_directories(${PROJECT_NAME}
  PUBLIC
    ${COSIM_TOOLS_INCLUDES}
    # where top-level project will look for the library's public headers
    $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/>
    # where external projects will look for the library's public headers
    $<INSTALL_INTERFACE:${CMAKE_INSTALL_INCLUDEDIR}>
)
