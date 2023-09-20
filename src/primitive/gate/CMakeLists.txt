cmake_minimum_required(VERSION 3.18)
project(Vgates)

find_package(verilator HINTS $ENV{VERILATOR_ROOT} ${VERILATOR_ROOT})
if (NOT verilator_FOUND)
  message(FATAL_ERROR "Verilator was not found. Either install it, or set the VERILATOR_ROOT environment variable")
endif()

set(INCLUDE_DIRS "../../..")
set(SOURCE_DIR ".")
set(VERILATOR_ARGS -cc --exe -x-assign fast --trace --assert --coverage)
set(GATE_NAMES
  "buf"
  "not"
  "and"
  "nand"
  "nor"
  "or"
  "xnor"
  "xor"
)

set(VERILATOR_INCLUDES $ENV{VERILATOR_ROOT}/include/)

foreach(gate IN LISTS GATE_NAMES)
  add_library(Vgate_${gate} STATIC)

  target_include_directories(Vgate_${gate}
    PUBLIC
      ${VERILATOR_INCLUDES}
      ${CMAKE_CURRENT_SOURCE_DIR}/build/CMakeFiles/Vgate_${gate}.dir/Vgate_${gate}.dir
      # where top-level project will look for the library's public headers
      $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/>
      # where external projects will look for the library's public headers
      $<INSTALL_INTERFACE:${CMAKE_INSTALL_INCLUDEDIR}>
  )

  verilate(Vgate_${gate}
    INCLUDE_DIRS ${INCLUDE_DIRS}
    SOURCES ${SOURCE_DIR}/gate_${gate}.v
    TOP_MODULE gate_${gate}
    VERILATOR_ARGS ${VERILATOR_ARGS}
  )
endforeach()
