cmake_minimum_required(VERSION 3.18)
project(Cosim_gates C CXX)

find_package(verilator HINTS $ENV{VERILATOR_ROOT} ${VERILATOR_ROOT})
if (NOT verilator_FOUND)
  message(FATAL_ERROR "Verilator was not found. Either install it, or set the VERILATOR_ROOT environment variable")
endif()

set(GATE_LIBRARIES
  "Vgate_buf"
  "Vgate_not"
  "Vgate_and"
  "Vgate_nand"
  "Vgate_nor"
  "Vgate_or"
  "Vgate_xnor"
  "Vgate_xor"
)

add_subdirectory(${CMAKE_CURRENT_SOURCE_DIR}/../../../src/primitive/gate vgates)

add_compile_options(-std=c++11)

add_library(${PROJECT_NAME} STATIC)

target_sources(${PROJECT_NAME} PRIVATE ./gate.cpp)

target_include_directories(${PROJECT_NAME}
  PUBLIC
  ${CMAKE_CURRENT_SOURCE_DIR}/gate.h
  # where top-level project will look for the library's public headers
  $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/>
  # where external projects will look for the library's public headers
  $<INSTALL_INTERFACE:${CMAKE_INSTALL_INCLUDEDIR}>
)

target_link_libraries(${PROJECT_NAME} LINK_PUBLIC ${GATE_LIBRARIES} Cosim_tools)

