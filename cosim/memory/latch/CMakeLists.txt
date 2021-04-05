set(MEM_SRC_LATCH ${PWD_LOGILIB}/memory/latch/src)

add_library(VDlatch STATIC)

verilator_generate_key(KEY_INIT)
set(PROTECT_KEY ${KEY_INIT} CACHE STRING "Random seed for protection")

verilate(VDlatch
  VERILATOR_ARGS --protect-lib lib_Dlatch
  --protect-key ${PROTECT_KEY}
  -I${PRIM_SRC_GATE}
#  --prof-cfuncs
  DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/lib/lib_Dlatch
  SOURCES ${MEM_SRC_LATCH}/Dlatch.v)

