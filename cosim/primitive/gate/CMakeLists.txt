function(gen_test_gate)
  cmake_parse_arguments(PARSE_ARGV 0 GATE
    "WAYS" "TARGET;NAME;WAY" ""
  )

  message(STATUS "Adding a test_gate ${GATE_NAME} to target ${GATE_TARGET}")
  configure_file(gate-tests.cpp.in Vgate_${GATE_NAME}_${GATE_WAY}-tests.cpp)
  target_sources(${GATE_TARGET} PRIVATE
    ${CMAKE_CURRENT_BINARY_DIR}/Vgate_${GATE_NAME}_${GATE_WAY}-tests.cpp
  )
endfunction()

target_sources(Vgate-tests PRIVATE gate-utils.cpp main-tests.cpp)

target_include_directories(Vgate-tests
  PRIVATE ${CMAKE_CURRENT_SOURCE_DIR} ${VERILATOR_ROOT}/include
)

target_link_libraries(Vgate-tests
  PRIVATE Boost::system Boost::unit_test_framework Vgate
)

target_compile_features(Vgate-tests PRIVATE cxx_std_20)

# Generate code for generic gates
list(APPEND GATE_NAMES "and" "nand" "nor" "or" "xnor" "xor")

gen_test_gate(TARGET Vgate-tests NAME buf WAY 1)
gen_test_gate(TARGET Vgate-tests NAME not WAY 1)
foreach(gate IN LISTS GATE_NAMES)
  foreach(way RANGE 2 ${MAX_WAYS})
    gen_test_gate(TARGET Vgate-tests NAME ${gate} WAY ${way})
    list(APPEND
      GENERIC_GATES_INCLUDES
      "#include \"Vgate_${gate}_${way}.h\""
    )

    list(APPEND
      GENERIC_GATES_TESTS
      "   {"
      "       auto* g = new GATE_TEST<Vgate_${gate}_${way}>(test_msb_${gate}, ${way})\;"
      "       g->open_trace()\;"
      "       error |= g->test()\;"
      "       delete g\;"
      "   }"
    )
  endforeach()
endforeach()
