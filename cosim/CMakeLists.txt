add_executable(Vgate-tests)

if (ENABLE_COSIM_PRIMITIVE)
  add_subdirectory(primitive)
endif()
