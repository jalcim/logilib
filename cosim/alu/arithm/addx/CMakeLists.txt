cmake_minimum_required(VERSION 3.18)
project(Cosim_addx C CXX)

include(environment)

INIT_ENVIRONMENT()

set(ADDX_LIBRARIES Vadd_1)

foreach(wires_number IN LISTS ARITHM_WIRES_LIST)
  set(ADDX_LIBRARIES
    ${ADDX_LIBRARIES}
    "VaddX_${wires_number}"
  )
endforeach()

# add_subdirectory(${CMAKE_CURRENT_SOURCE_DIR}/../../../../src/alu/arithm addx)

add_subdirectory(${CMAKE_CURRENT_SOURCE_DIR}/../../../../synth/alu/arithm/verilog vaddx)


add_library(${PROJECT_NAME} STATIC)

target_sources(${PROJECT_NAME} PRIVATE ./addx.cpp ./addx_test.cpp)

target_include_directories(${PROJECT_NAME}
  PUBLIC
  ${CMAKE_CURRENT_SOURCE_DIR}/Vadd.h
  # where top-level project will look for the library's public headers
  $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/>
  # where external projects will look for the library's public headers
  $<INSTALL_INTERFACE:${CMAKE_INSTALL_INCLUDEDIR}>
)

target_link_libraries(${PROJECT_NAME} LINK_PUBLIC ${ADDX_LIBRARIES} Boost::log)

