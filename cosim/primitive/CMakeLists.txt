file(MAKE_DIRECTORY ${CMAKE_BINARY_DIR}/signal)

if (ENABLE_COSIM_PRIMITIVE_GATE)
  file(MAKE_DIRECTORY ${CMAKE_BINARY_DIR}/signal/primitive/gate)
  add_subdirectory(gate)
endif()
