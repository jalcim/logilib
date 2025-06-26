add_executable(Vgate-tests)
add_executable(Vbru-tests)

if (ENABLE_COSIM_PRIMITIVE)
  add_subdirectory(primitive)
endif()

if (ENABLE_COSIM_MEMORY)
  add_subdirectory(memory)
endif()

if (ENABLE_COSIM_EXEMPLE)
  add_subdirectory(exemple)
endif()
