function(add_gate)
  cmake_parse_arguments(PARSE_ARGV 0 GATE
    "WAYS" "TARGET;NAME;WAY" ""
  )

  set (GATE_ARGS ${VERILATOR_ARGS})
  if (${GATE_WAYS})
    set (GATE_ARGS ${GATE_ARGS} -GWAY=${GATE_WAY})
  endif()

  message(STATUS "Adding a gate ${GATE_NAME} to target ${GATE_TARGET}")
  verilate(${GATE_TARGET}
    INCLUDE_DIRS ${CMAKE_SOURCE_DIR}
    SOURCES gate_${GATE_NAME}.v
    TOP_MODULE gate_${GATE_NAME}
    VERILATOR_ARGS ${GATE_ARGS}
    PREFIX Vgate_${GATE_NAME}_${GATE_WAY}
  )

endfunction()

set(VERILATOR_ARGS
    -cc
    --exe
    -x-assign fast
    --trace
    --no-decoration
    --assert
    --coverage
)

set(GATE_NAMES
  "and"
  "nand"
  "nor"
  "or"
  "xnor"
  "xor"
)

add_library(Vgate STATIC)

target_include_directories(Vgate
    PUBLIC ${VERILATOR_ROOT}/include
)

target_compile_features(Vgate PUBLIC cxx_std_20)

# Génération des gates avec Verilator
add_gate(TARGET Vgate NAME buf WAY 1)
add_gate(TARGET Vgate NAME not WAY 1)

foreach(g IN LISTS GATE_NAMES)
  foreach(w RANGE 2 ${MAX_WAYS})
    add_gate(TARGET Vgate NAME ${g} WAY ${w})
  endforeach()
endforeach()
