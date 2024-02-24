cmake_minimum_required(VERSION 3.18)
project(arithm)

find_package(verilator HINTS $ENV{VERILATOR_ROOT} ${VERILATOR_ROOT})
if (NOT verilator_FOUND)
  message(FATAL_ERROR "Verilator was not found. Either install it, or set the VERILATOR_ROOT environment variable")
endif()

set(INCLUDE_DIRS "../../..")

if(NOT DEFINED ARITHM_WIRES_LIST)
  set(ARITHM_WIRES_LIST 1 2 3 4 7 8 16 32)
endif()

if(NOT DEFINED ARITHM_NAMES)
  set(ARITHM_NAMES
    "add"
    "add_sub"
    "addX"
    "cmp"
    "divmod2"
    "multX"
  )
endif()

if(NOT DEFINED VERILATOR_INCLUDES)
  set(VERILATOR_INCLUDES $ENV{VERILATOR_ROOT}/include/)
endif()

if(NOT DEFINED VERILATOR_ARGS)
  set(VERILATOR_ARGS -cc --exe -x-assign fast --trace --no-decoration --assert --coverage)
endif()

set(SOURCE_DIR ".")

foreach(module_name IN LISTS ARITHM_NAMES)
  message(STATUS "Compiling ${module_name} ${CMAKE_CURRENT_SOURCE_DIR}")
  if (${module_name} STREQUAL "add")
    add_custom_target(${module_name}_1.v ALL DEPENDS ${CMAKE_CURRENT_SOURCE_DIR}/../../../synth/alu/arithm/verilog/${module_name}_1.v)
    add_custom_command(
      OUTPUT ${CMAKE_CURRENT_SOURCE_DIR}/../../../synth/alu/arithm/verilog/${module_name}_1.v
      COMMAND  yosys -v 99 -q -c scripts/yosys/alu/arithm/arithm.tcl -- alu ${module_name} 1
      WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}/../../../
      DEPENDS "${CMAKE_CURRENT_SOURCE_DIR}/${module_name}.v"
      COMMENT "Synthetize ${module_name}_1"
      VERBATIM
    )

  else()
    foreach(wire_number IN LISTS ARITHM_WIRES_LIST)
      add_custom_target(${module_name}_${wire_number}.v ALL DEPENDS ${CMAKE_CURRENT_SOURCE_DIR}/../../../synth/alu/arithm/verilog/${module_name}_${wire_number}.v)
      add_custom_command(
        OUTPUT ${CMAKE_CURRENT_SOURCE_DIR}/../../../synth/alu/arithm/verilog/${module_name}_${wire_number}.v
        COMMAND  yosys -v 99 -q -c scripts/yosys/alu/arithm/arithm.tcl -- alu ${module_name} ${wire_number}
        WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}/../../../
        DEPENDS "${CMAKE_CURRENT_SOURCE_DIR}/${module_name}.v"
        COMMENT "Synthetize ${module_name}_${wire_number}"
        VERBATIM
      )
    endforeach()
  endif()
endforeach()
