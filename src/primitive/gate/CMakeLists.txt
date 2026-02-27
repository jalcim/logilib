function(add_gate)
  cmake_parse_arguments(PARSE_ARGV 0 GATE "WAYS" "TARGET;NAME;WAY;WIRE" "")

  set(GATE_ARGS ${VERILATOR_ARGS})
  if(GATE_WAY GREATER 1)
    list(APPEND GATE_ARGS -GWAY=${GATE_WAY} -GWIRE=${GATE_WIRE})
  elseif(GATE_WAY EQUAL 1)
    list(APPEND GATE_ARGS -GWIRE=${GATE_WIRE})
  endif()

  
  message(STATUS "Adding gate ${GATE_NAME} to target ${GATE_TARGET} way=${GATE_WAY} wire=${GATE_WIRE}")
  verilate(${GATE_TARGET}
    INCLUDE_DIRS ${CMAKE_SOURCE_DIR}
    SOURCES gate_${GATE_NAME}.v
    TOP_MODULE gate_${GATE_NAME}
    VERILATOR_ARGS ${GATE_ARGS}
    PREFIX Vgate_${GATE_NAME}_${GATE_WAY}_${GATE_WIRE}
  )

#  configure_file(gates.py.in gate_${GATE_NAME}_${GATE_WAY}_${GATE_WIRE}.py)

endfunction()

add_library(Vgate STATIC)
target_include_directories(Vgate PUBLIC ${VERILATOR_ROOT}/include)
target_compile_features(Vgate PUBLIC cxx_std_20)
get_property(GATE_FILE GLOBAL PROPERTY PRIMITIVE_FILE)  # récupère
set(VERILATOR_ARGS -cc --exe -x-assign fast --trace --no-decoration --assert --coverage)

# Génération des gates avec Verilator
foreach(wire RANGE 1 ${MAX_WIRE})
  add_gate(TARGET Vgate NAME buf WAY 1 WIRE ${wire})
  add_gate(TARGET Vgate NAME not WAY 1 WIRE ${wire})
endforeach()

set(GATE_NAMES "and" "nand" "nor" "or" "xnor" "xor")
foreach (GATE IN LISTS GATE_NAMES)
  list(APPEND GATE_FILE gate_${GATE}.v)
  foreach (WAY RANGE 2 ${MAX_WAYS})
    foreach (WIRE RANGE 1 ${MAX_WIRE})
      add_gate(TARGET Vgate NAME ${GATE} WAY ${WAY} WIRE ${WIRE})
    endforeach()
  endforeach()
endforeach()

set_property(GLOBAL PROPERTY PRIMITIVE_FILE "${GATE_FILE}")  # met à jour
