function(gen_test_gate)
  cmake_parse_arguments(PARSE_ARGV 0 GATE
    "WAYS" "TARGET;NAME;WAY;WIRE" ""
  )

  message(STATUS "Adding a test_gate ${GATE_NAME} to target ${GATE_TARGET}")
  configure_file(gate-tests.cpp.in Vgate_${GATE_NAME}_${GATE_WAY}_${GATE_WIRE}-tests.cpp)
  target_sources(${GATE_TARGET} PRIVATE
    ${CMAKE_CURRENT_BINARY_DIR}/Vgate_${GATE_NAME}_${GATE_WAY}_${GATE_WIRE}-tests.cpp)
endfunction()

target_sources(Vgate-tests PRIVATE
  gate-utils.cpp main-tests.cpp
  test_buf.cpp test_not.cpp
  test_and.cpp test_nand.cpp
  test_or.cpp test_nor.cpp
  test_xor.cpp test_xnor.cpp)

target_include_directories(Vgate-tests PRIVATE ${CMAKE_CURRENT_SOURCE_DIR} ${VERILATOR_ROOT}/include)
target_link_libraries(Vgate-tests PRIVATE Boost::system Boost::unit_test_framework Vgate)
target_compile_features(Vgate-tests PRIVATE cxx_std_20)

# Generate code for generic gates
foreach(wire RANGE 1 ${MAX_WIRE})
  gen_test_gate(TARGET Vgate-tests NAME buf WAY 1 WIRE ${wire})
  gen_test_gate(TARGET Vgate-tests NAME not WAY 1 WIRE ${wire})
endforeach()

list(APPEND GATE_NAMES "and" "nand" "nor" "or" "xnor" "xor")
foreach(gate IN LISTS GATE_NAMES)
  foreach(way RANGE 2 ${MAX_WAYS})
    foreach(wire RANGE 2 ${MAX_WIRE})
      gen_test_gate(TARGET Vgate-tests NAME ${gate} WAY ${way} WIRE ${wire})
    endforeach()
  endforeach()
endforeach()
