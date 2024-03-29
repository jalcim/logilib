add_library(Vgate_buf STATIC)
add_library(Vgate_not STATIC)
add_library(Vgate_and STATIC)
add_library(Vgate_nand STATIC)
add_library(Vgate_nor STATIC)
add_library(Vgate_or STATIC)
add_library(Vgate_xnor STATIC)
add_library(Vgate_xor STATIC)

verilator_generate_key(KEY_INIT)
set(PROTECT_KEY ${KEY_INIT} CACHE STRING "Random seed for protection")

verilate(Vgate_buf
  VERILATOR_ARGS --protect-lib lib_gate_buf
  --protect-key ${PROTECT_KEY}
  DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/lib/lib_gate_buf
  SOURCES ${PRIM_SRC_GATE}/gate_buf.v)

verilate(Vgate_not
  VERILATOR_ARGS --protect-lib lib_gate_not
  --protect-key ${PROTECT_KEY}
  DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/lib/lib_gate_not
  SOURCES ${PRIM_SRC_GATE}/gate_not.v)

verilate(Vgate_and
  VERILATOR_ARGS --protect-lib lib_gate_and
  --protect-key ${PROTECT_KEY}
  DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/lib/lib_gate_and
  SOURCES ${PRIM_SRC_GATE}/gate_and.v)

verilate(Vgate_nand
  VERILATOR_ARGS --protect-lib lib_gate_nand
  --protect-key ${PROTECT_KEY}
  DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/lib/lib_gate_nand
  SOURCES ${PRIM_SRC_GATE}/gate_nand.v)

verilate(Vgate_nor
  VERILATOR_ARGS --protect-lib lib_gate_nor
  --protect-key ${PROTECT_KEY}
  DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/lib/lib_gate_nor
  SOURCES ${PRIM_SRC_GATE}/gate_nor.v)

verilate(Vgate_or
  VERILATOR_ARGS --protect-lib lib_gate_or
  --protect-key ${PROTECT_KEY}
  DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/lib/lib_gate_or
  SOURCES ${PRIM_SRC_GATE}/gate_or.v)

verilate(Vgate_xnor
  VERILATOR_ARGS --protect-lib lib_gate_xnor
  --protect-key ${PROTECT_KEY}
  DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/lib/lib_gate_xnor
  SOURCES ${PRIM_SRC_GATE}/gate_xnor.v)

verilate(Vgate_xor
  VERILATOR_ARGS --protect-lib lib_gate_xor
  --protect-key ${PROTECT_KEY}
  DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/lib/lib_gate_xor
  SOURCES ${PRIM_SRC_GATE}/gate_xor.v)
