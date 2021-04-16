set(PWD_LOGILIB ${CMAKE_CURRENT_SOURCE_DIR}/..)

set(SRC main.cpp
  primitive/gate/gate.cpp
  primitive/parallel_gate/parallel_gate.cpp
  memory/latch/latch.cpp
  alu/arithm/arithm.cpp)

set(PRIM_SRC_GATE ${PWD_LOGILIB}/primitive/gate/src)
set(PRIM_GATE_LIB
  Vgate_buf Vgate_not Vgate_and Vgate_nand
  Vgate_nor Vgate_or  Vgate_xnor Vgate_xor)

set(PRIM_PARALLEL_GATE_LIB
  Vparallel_gate_buf Vparallel_gate_not
  Vparallel_gate_and Vparallel_gate_nand
  Vparallel_gate_or Vparallel_gate_nor
  Vparallel_gate_xor Vparallel_gate_xnor)

set(MEM_LATCH_LIB
  VDlatch)

set(ALU_LIB
  Vadd Vmulti_add)
#set(CMAKE_CPPFLAGS "${CMAKE_CPPFLAGS} -DVL_DEBUG")
cmake_minimum_required(VERSION 3.20)
project(cmake_cosim)
find_package(verilator HINTS $ENV{VERILATOR_ROOT})
set(CMAKE_BUILD_TYPE Debug)
add_executable(Vmain ${SRC})
add_subdirectory(primitive)
add_subdirectory(memory)
add_subdirectory(alu)
target_link_libraries(Vmain PRIVATE
  ${PRIM_GATE_LIB} ${PRIM_PARALLEL_GATE_LIB} ${MEM_LATCH_LIB} ${ALU_LIB})
