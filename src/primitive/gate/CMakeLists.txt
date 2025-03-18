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

  if (TESTS)
    configure_file(gate-tests.cpp.in Vgate_${GATE_NAME}_${GATE_WAY}-tests.cpp)
    target_sources(${GATE_TARGET}-tests PRIVATE
      ${CMAKE_CURRENT_BINARY_DIR}/Vgate_${GATE_NAME}_${GATE_WAY}-tests.cpp
    )
  endif()
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
  PUBLIC
  ${VERILATOR_ROOT}/include
)

target_compile_features(Vgate
    PUBLIC
        cxx_std_20
)

add_executable(Vgate-tests
    gate-utils.cpp
    main-tests.cpp
)

target_include_directories(Vgate-tests
    PUBLIC
        ${CMAKE_CURRENT_SOURCE_DIR}
        ${VERILATOR_ROOT}/include
)

target_link_libraries(Vgate-tests
    PRIVATE
        Boost::system
        Boost::unit_test_framework
        Vgate
)

target_compile_features(Vgate-tests
    PUBLIC
        cxx_std_20
)

add_gate(TARGET Vgate NAME buf WAY 1)
add_gate(TARGET Vgate NAME not WAY 1)

foreach(gate IN LISTS GATE_NAMES)
  foreach(way_number RANGE 2 ${MAX_WAYS})
    message(STATUS "Vgate ${gate} ${way_number}")
    add_gate(TARGET Vgate NAME ${gate} WAY ${way_number})
  endforeach()
endforeach()
