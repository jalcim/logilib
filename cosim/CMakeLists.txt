add_executable(Vgate-tests)

if (ENABLE_COSIM_PRIMITIVE)
  file(MAKE_DIRECTORY ${CMAKE_BINARY_DIR}/signal/primitive)
  add_subdirectory(primitive)
endif()

if (ENABLE_COSIM_MEMORY)
  file(MAKE_DIRECTORY ${CMAKE_BINARY_DIR}/signal/memory)
  add_subdirectory(memory)
endif()
