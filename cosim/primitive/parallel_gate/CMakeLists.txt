set(PRIM_SRC_PARALLEL_GATE "../../../primitive/parallel_gate/src")

add_library(Vparallel_gate_buf STATIC)
add_library(Vparallel_gate_not STATIC)
add_library(Vparallel_gate_and STATIC)
add_library(Vparallel_gate_nand STATIC)
add_library(Vparallel_gate_or STATIC)
add_library(Vparallel_gate_nor STATIC)
add_library(Vparallel_gate_xor STATIC)
add_library(Vparallel_gate_xnor STATIC)

verilator_generate_key(KEY_INIT)
set(PROTECT_KEY ${KEY_INIT} CACHE STRING "Random seed for protection")

verilate(Vparallel_gate_buf
  VERILATOR_ARGS --protect-lib lib_parallel_gate_buf
  --protect-key ${PROTECT_KEY}
  -I${PRIM_SRC_GATE}
  DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/lib/lib_parallel_gate_buf
  SOURCES ${PRIM_SRC_PARALLEL_GATE}/parallel_gate_buf.v)

verilate(Vparallel_gate_not
  VERILATOR_ARGS --protect-lib lib_parallel_gate_not
  --protect-key ${PROTECT_KEY}
  -I${PRIM_SRC_GATE}
  DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/lib/lib_parallel_gate_not
  SOURCES ${PRIM_SRC_PARALLEL_GATE}/parallel_gate_not.v)

verilate(Vparallel_gate_and
  VERILATOR_ARGS --protect-lib lib_parallel_gate_and
  --protect-key ${PROTECT_KEY}
  -I${PRIM_SRC_GATE}
  DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/lib/lib_parallel_gate_and
  SOURCES ${PRIM_SRC_PARALLEL_GATE}/parallel_gate_and.v)

verilate(Vparallel_gate_nand
  VERILATOR_ARGS --protect-lib lib_parallel_gate_nand
  --protect-key ${PROTECT_KEY}
  -I${PRIM_SRC_GATE}
  DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/lib/lib_parallel_gate_nand
  SOURCES ${PRIM_SRC_PARALLEL_GATE}/parallel_gate_nand.v)

verilate(Vparallel_gate_or
  VERILATOR_ARGS --protect-lib lib_parallel_gate_or
  --protect-key ${PROTECT_KEY}
  -I${PRIM_SRC_GATE}
  DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/lib/lib_parallel_gate_or
  SOURCES ${PRIM_SRC_PARALLEL_GATE}/parallel_gate_or.v)

verilate(Vparallel_gate_nor
  VERILATOR_ARGS --protect-lib lib_parallel_gate_nor
  --protect-key ${PROTECT_KEY}
  -I${PRIM_SRC_GATE}
  DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/lib/lib_parallel_gate_nor
  SOURCES ${PRIM_SRC_PARALLEL_GATE}/parallel_gate_nor.v)

verilate(Vparallel_gate_xor
  VERILATOR_ARGS --protect-lib lib_parallel_gate_xor
  --protect-key ${PROTECT_KEY}
  -I${PRIM_SRC_GATE}
  DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/lib/lib_parallel_gate_xor
  SOURCES ${PRIM_SRC_PARALLEL_GATE}/parallel_gate_xor.v)

verilate(Vparallel_gate_xnor
  VERILATOR_ARGS --protect-lib lib_parallel_gate_xnor
  --protect-key ${PROTECT_KEY}
  -I${PRIM_SRC_GATE}
  DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/lib/lib_parallel_gate_xnor
  SOURCES ${PRIM_SRC_PARALLEL_GATE}/parallel_gate_xnor.v)
