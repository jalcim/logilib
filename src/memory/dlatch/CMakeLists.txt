function (add_Dlatch)
  cmake_parse_arguments(PARSE_ARGV 0 DLATCH "" "TARGET" "")

  message(STATUS "Adding Dlatch ${DLATCH_NAME} to target ${DLATCH_TARGET}")
  verilate(${DLATCH_TARGET}
    INCLUDE_DIRS ${CMAKE_SOURCE_DIR}
    SOURCES Dlatch.v #_${DLATCH_NAME}.v
    TOP_MODULE Dlatch #_${DLATCH_NAME}
    VERILATOR_ARGS ${DLATCH_ARGS}
    PREFIX VDlatch #_${DLATCH_NAME}
  )
endfunction()

add_library(VDlatch STATIC)

target_include_directories(VDlatch PUBLIC ${VERILATOR_ROOT}/include)

target_compile_features(VDlatch PUBLIC cxx_std_20)

add_Dlatch(TARGET VDlatch)
