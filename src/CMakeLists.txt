if (ENABLE_SRC_PRIMITIVE)
  set_property(GLOBAL PROPERTY PRIMITIVE_FILE "")

  add_subdirectory(primitive)

  get_property(GATE_FILE GLOBAL PROPERTY PRIMITIVE_FILE)
  message(STATUS "\nListe concaténée : ${GATE_FILE}\n")

  file(WRITE my_lib.v "")
  foreach(f IN LISTS GATE_FILE)
  file(READ "primitive/gate/${f}" CONTENT)
  string(REGEX REPLACE "[^\n]*`include[^\n]*(\n|$)" "" CONTENT "${CONTENT}")
  file(APPEND my_lib.v "${CONTENT}\n")
  endforeach()

endif()

if (ENABLE_SRC_MEMORY)
  add_subdirectory(memory)
endif()
