if (ENABLE_COSIM_PRIMITIVE_GATE)
  #    add_executable(test_gate test_gate.cpp)

  #    target_link_libraries(test_gate
  #        PRIVATE Boost::system Boost::unit_test_framework
  #    )

  #    target_compile_features(test_gate PUBLIC cxx_std_20)

  add_library(cosim_primitive_gate gate_utils.cpp)

  target_include_directories(cosim_primitive
    PUBLIC ${CMAKE_CURRENT_SOURCE_DIR}
  )

    # Generate code for generic gates
    list(APPEND GATE_NAMES "and" "nand" "nor" "or" "xnor" "xor")

    foreach(gate IN LISTS GATE_NAMES)
      foreach(way RANGE 2 ${MAX_WAYS})
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

    list(JOIN GENERIC_GATES_INCLUDES "\n" GENERIC_GATES_INCLUDES)
    configure_file(gates.hpp.in gates.hpp)

    list(JOIN GENERIC_GATES_TESTS "\n" GENERIC_GATES_TESTS)
    configure_file(gates.cpp.in gates.cpp)
    target_sources(cosim PRIVATE ${CMAKE_CURRENT_BINARY_DIR}/gates.cpp)

endif()
