cmake_minimum_required(VERSION 3.18)
project(Cosim_add_sub C CXX)

include(environment)

INIT_ENVIRONMENT()

set(ADD_SUB_LIBRARIES Vadd_1 verif_arithm)

foreach(wires_number IN LISTS ARITHM_WIRES_LIST)
  set(ADD_SUB_LIBRARIES
    ${ADD_SUB_LIBRARIES}
    "Vadd_sub_${wires_number}"
  )
endforeach()

set(ARITHM_NAMES
  "add_sub"
)

add_subdirectory(${CMAKE_CURRENT_SOURCE_DIR}/../../../../synth/alu/arithm/verilog vadd_sub)

if(NOT TARGET verif_arithm)
  add_subdirectory(${CMAKE_CURRENT_SOURCE_DIR}/../../../../veriform/alu/arithm verif_arithm)
endif()

add_library(${PROJECT_NAME} STATIC)

target_sources(${PROJECT_NAME} PRIVATE ./add_sub.cpp ./add_sub_test.cpp)

target_include_directories(${PROJECT_NAME}
  PRIVATE
    ${CMAKE_CURRENT_SOURCE_DIR}/../../../../veriform/alu/arithm
  PUBLIC
    ${CMAKE_CURRENT_SOURCE_DIR}/add_sub.h
    # where top-level project will look for the library's public headers
    $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/>
    # where external projects will look for the library's public headers
    $<INSTALL_INTERFACE:${CMAKE_INSTALL_INCLUDEDIR}>
)

target_link_libraries(${PROJECT_NAME} LINK_PUBLIC ${ADD_SUB_LIBRARIES} Boost::log)

