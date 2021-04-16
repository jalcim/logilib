set(ALU_SRC_ARITHM ${PWD_LOGILIB}/alu/arithm/src)

add_library(Vadd STATIC)
add_library(Vmulti_add STATIC)

verilator_generate_key(KEY_INIT)
set(PROTECT_KEY ${KEY_INIT} CACHE STRING "Random seed for protection")

verilate(Vadd
  VERILATOR_ARGS --protect-lib lib_add
  --protect-key ${PROTECT_KEY}
  -I${PRIM_SRC_GATE}
  DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/lib/lib_add
  SOURCES ${ALU_SRC_ARITHM}/add.v)

verilate(Vmulti_add
  VERILATOR_ARGS --protect-lib lib_multi_add
  --protect-key ${PROTECT_KEY}
  -I${PRIM_SRC_GATE} -I${ALU_SRC_ARITHM}
  DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/lib/lib_multi_add
  SOURCES ${ALU_SRC_ARITHM}/multi_add.v)
