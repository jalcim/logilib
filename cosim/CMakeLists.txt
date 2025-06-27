add_executable(Vgate-tests)

if (ENABLE_COSIM_PRIMITIVE)
  add_subdirectory(primitive)
endif()

if (ENABLE_COSIM_MEMORY)
  add_subdirectory(memory)
endif()
