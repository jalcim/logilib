function(Dlatch)
  add_library(VDlatch STATIC)
  target_include_directories(VDlatch PUBLIC ${VERILATOR_ROOT}/include)
  target_compile_features(VDlatch PUBLIC cxx_std_20)
  verilate(VDlatch
    INCLUDE_DIRS ${CMAKE_SOURCE_DIR}
    SOURCES Dlatch.v
    TOP_MODULE Dlatch
    VERILATOR_ARGS ${DLATCH_ARGS}
    PREFIX VDlatch
  )
endfunction ()

function(Dlatch_rst)
  add_library(VDlatch_rst STATIC)
  target_include_directories(VDlatch_rst PUBLIC ${VERILATOR_ROOT}/include)
  target_compile_features(VDlatch_rst PUBLIC cxx_std_20)
  verilate(VDlatch_rst
    INCLUDE_DIRS ${CMAKE_SOURCE_DIR}
    SOURCES Dlatch_rst.v
    TOP_MODULE Dlatch_rst
    VERILATOR_ARGS ${DLATCH_ARGS}
    PREFIX VDlatch_rst
  )
endfunction ()

function(Dlatch_pre)
  add_library(VDlatch_pre STATIC)
  target_include_directories(VDlatch_pre PUBLIC ${VERILATOR_ROOT}/include)
  target_compile_features(VDlatch_pre PUBLIC cxx_std_20)
  verilate(VDlatch_pre
    INCLUDE_DIRS ${CMAKE_SOURCE_DIR}
    SOURCES Dlatch_pre.v
    TOP_MODULE Dlatch_pre
    VERILATOR_ARGS ${DLATCH_ARGS}
    PREFIX VDlatch_pre
  )
endfunction ()

function(Dlatch_rst_pre)
  add_library(VDlatch_rst_pre STATIC)
  target_include_directories(VDlatch_rst_pre PUBLIC ${VERILATOR_ROOT}/include)
  target_compile_features(VDlatch_rst_pre PUBLIC cxx_std_20)
  verilate(VDlatch_rst_pre
    INCLUDE_DIRS ${CMAKE_SOURCE_DIR}
    SOURCES Dlatch_rst_pre.v
    TOP_MODULE Dlatch_rst_pre
    VERILATOR_ARGS ${DLATCH_ARGS}
    PREFIX VDlatch_rst_pre
  )
endfunction ()

Dlatch()
Dlatch_rst()
Dlatch_pre()
Dlatch_rst_pre()
