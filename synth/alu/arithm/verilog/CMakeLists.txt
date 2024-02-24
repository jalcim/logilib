cmake_minimum_required(VERSION 3.18)
project(Varithm)

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
  set(VERILATOR_ARGS -Wno-unoptflat -cc --exe -x-assign fast --trace --no-decoration --assert --coverage)
endif()

set(SOURCE_DIR ".")

foreach(module_name IN LISTS ARITHM_NAMES)
  if (${module_name} STREQUAL "add")
    message(STATUS "Creating lib V${module_name}_1 ${CMAKE_BINARY_DIR}")
    add_library(V${module_name}_1 STATIC)

    target_include_directories(V${module_name}_1
    PUBLIC
      ${VERILATOR_INCLUDES}
      ${CMAKE_BINARY_DIR}/../src/alu/arithm/CMakeFiles/${module_name}_1.v.dir/
      # where top-level project will look for the library's public headers
      $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/>
      # where external projects will look for the library's public headers
      $<INSTALL_INTERFACE:${CMAKE_INSTALL_INCLUDEDIR}>
    )

    verilate(V${module_name}_1
      INCLUDE_DIRS ${INCLUDE_DIRS}
      SOURCES ${CMAKE_CURRENT_SOURCE_DIR}/${module_name}_1.v
      TOP_MODULE ${module_name}_1
      VERILATOR_ARGS ${VERILATOR_ARGS}
      PREFIX V${module_name}_1
    )
  else()
    foreach(wire_number IN LISTS ARITHM_WIRES_LIST)
      message(STATUS "Creating lib V${module_name}_1")
      add_library(V${module_name}_${wire_number} STATIC)
      target_include_directories(V${module_name}_${wire_number}
        PUBLIC
          ${VERILATOR_INCLUDES}
          ${CMAKE_BINARY_DIR}/CMakeFiles/V${module_name}_${wire_number}.dir/V${module_name}_${wire_number}.dir
          # where top-level project will look for the library's public headers
          $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/>
          # where external projects will look for the library's public headers
          $<INSTALL_INTERFACE:${CMAKE_INSTALL_INCLUDEDIR}>
      )

      verilate(V${module_name}_${wire_number}
        INCLUDE_DIRS ${INCLUDE_DIRS}
        SOURCES ${SOURCE_DIR}/${module_name}_${wire_number}.v
        TOP_MODULE ${module_name}_${wire_number}
        VERILATOR_ARGS ${VERILATOR_ARGS}
        PREFIX V${module_name}_${wire_number}
      )
    endforeach()
  endif()
endforeach()
