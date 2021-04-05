set(SRC main.cpp
  primitive/gate/gate.cpp
  primitive/parallel_gate/parallel_gate.cpp)

set(PRIM_SRC_GATE "../../../primitive/gate/src")
set(PRIM_GATE_LIB
  Vgate_buf Vgate_not Vgate_and Vgate_nand
  Vgate_nor Vgate_or  Vgate_xnor Vgate_xor)

set(PRIM_PARALLEL_GATE_LIB
  Vparallel_gate_buf Vparallel_gate_not
  Vparallel_gate_and Vparallel_gate_nand
  Vparallel_gate_or Vparallel_gate_nor
  Vparallel_gate_xor Vparallel_gate_xnor)
  
cmake_minimum_required(VERSION 3.20)
project(cmake_cosim)
find_package(verilator HINTS $ENV{VERILATOR_ROOT})
set(CMAKE_BUILD_TYPE Debug)
add_executable(Vmain ${SRC})
add_subdirectory(primitive)
target_link_libraries(Vmain PRIVATE
  ${PRIM_GATE_LIB} ${PRIM_PARALLEL_GATE_LIB})
