cmake_minimum_required(VERSION 3.18)
project(Vgates)

find_package(verilator HINTS $ENV{VERILATOR_ROOT} ${VERILATOR_ROOT})
if (NOT verilator_FOUND)
  message(FATAL_ERROR "Verilator was not found. Either install it, or set the VERILATOR_ROOT environment variable")
endif()

set(INCLUDE_DIRS "../../..")

if(NOT DEFINED MAX_WAYS)
  set(MAX_WAYS 8)
endif()

set(SOURCE_DIR ".")
set(VERILATOR_ARGS -cc --exe -x-assign fast --trace --no-decoration --assert --coverage)
set(GATE_NAMES
  "and"
  "nand"
  "nor"
  "or"
  "xnor"
  "xor"
)

set(VERILATOR_INCLUDES $ENV{VERILATOR_ROOT}/include/)

add_library(Vgate_buf_1 STATIC)

target_include_directories(Vgate_buf_1
  PUBLIC
    ${VERILATOR_INCLUDES}
    ${CMAKE_CURRENT_SOURCE_DIR}/build/CMakeFiles/Vgate_buf_1.dir/Vgate_buf_1.dir
    # where top-level project will look for the library's public headers
    $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/>
    # where external projects will look for the library's public headers
    $<INSTALL_INTERFACE:${CMAKE_INSTALL_INCLUDEDIR}>
)

verilate(Vgate_buf_1
  INCLUDE_DIRS ${INCLUDE_DIRS}
  SOURCES ${SOURCE_DIR}/gate_buf.v
  TOP_MODULE gate_buf
  VERILATOR_ARGS ${VERILATOR_ARGS}
  PREFIX Vgate_buf_1
)

add_library(Vgate_not_1 STATIC)

target_include_directories(Vgate_not_1
  PUBLIC
    ${VERILATOR_INCLUDES}
    ${CMAKE_CURRENT_SOURCE_DIR}/build/CMakeFiles/Vgate_not_1.dir/Vgate_not_1.dir
    # where top-level project will look for the library's public headers
    $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/>
    # where external projects will look for the library's public headers
    $<INSTALL_INTERFACE:${CMAKE_INSTALL_INCLUDEDIR}>
)

verilate(Vgate_not_1
  INCLUDE_DIRS ${INCLUDE_DIRS}
  SOURCES ${SOURCE_DIR}/gate_not.v
  TOP_MODULE gate_not
  VERILATOR_ARGS ${VERILATOR_ARGS}
  PREFIX Vgate_not_1
)

foreach(gate IN LISTS GATE_NAMES)

foreach(way_number RANGE 2 ${MAX_WAYS})
    add_library(Vgate_${gate}_${way_number} STATIC)
    target_include_directories(Vgate_${gate}_${way_number}
      PUBLIC
        ${VERILATOR_INCLUDES}
        ${CMAKE_CURRENT_SOURCE_DIR}/build/CMakeFiles/Vgate_${gate}_${way_number}.dir/Vgate_${gate}_${way_number}.dir
        # where top-level project will look for the library's public headers
        $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/>
        # where external projects will look for the library's public headers
        $<INSTALL_INTERFACE:${CMAKE_INSTALL_INCLUDEDIR}>
    )

    verilate(Vgate_${gate}_${way_number}
      INCLUDE_DIRS ${INCLUDE_DIRS}
      SOURCES ${SOURCE_DIR}/gate_${gate}.v
      TOP_MODULE gate_${gate}
      VERILATOR_ARGS ${VERILATOR_ARGS} -GWAY=${way_number}
      PREFIX Vgate_${gate}_${way_number}
    )
  endforeach()
endforeach()
