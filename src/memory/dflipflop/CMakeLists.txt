function(Dflipflop)
  add_library(VDflipflop STATIC)
  target_include_directories(VDflipflop PUBLIC ${VERILATOR_ROOT}/include)
  target_compile_features(VDflipflop PUBLIC cxx_std_20)
  verilate(VDflipflop
    INCLUDE_DIRS ${CMAKE_SOURCE_DIR}
    SOURCES Dflipflop.v
    TOP_MODULE Dflipflop
    VERILATOR_ARGS ${DLATCH_ARGS}
    PREFIX VDflipflop
  )
endfunction ()

function(Dflipflop_rst)
  add_library(VDflipflop_rst STATIC)
  target_include_directories(VDflipflop_rst PUBLIC ${VERILATOR_ROOT}/include)
  target_compile_features(VDflipflop_rst PUBLIC cxx_std_20)
  verilate(VDflipflop_rst
    INCLUDE_DIRS ${CMAKE_SOURCE_DIR}
    SOURCES Dflipflop_rst.v
    TOP_MODULE Dflipflop_rst
    VERILATOR_ARGS ${DLATCH_ARGS}
    PREFIX VDflipflop_rst
  )
endfunction ()

function(Dflipflop_pre)
  add_library(VDflipflop_pre STATIC)
  target_include_directories(VDflipflop_pre PUBLIC ${VERILATOR_ROOT}/include)
  target_compile_features(VDflipflop_pre PUBLIC cxx_std_20)
  verilate(VDflipflop_pre
    INCLUDE_DIRS ${CMAKE_SOURCE_DIR}
    SOURCES Dflipflop_pre.v
    TOP_MODULE Dflipflop_pre
    VERILATOR_ARGS ${DLATCH_ARGS}
    PREFIX VDflipflop_pre
  )
endfunction ()

function(Dflipflop_rst_pre)
  add_library(VDflipflop_rst_pre STATIC)
  target_include_directories(VDflipflop_rst_pre PUBLIC ${VERILATOR_ROOT}/include)
  target_compile_features(VDflipflop_rst_pre PUBLIC cxx_std_20)
  verilate(VDflipflop_rst_pre
    INCLUDE_DIRS ${CMAKE_SOURCE_DIR}
    SOURCES Dflipflop_rst_pre.v
    TOP_MODULE Dflipflop_rst_pre
    VERILATOR_ARGS ${DLATCH_ARGS}
    PREFIX VDflipflop_rst_pre
  )
endfunction ()

Dflipflop()
Dflipflop_rst()
Dflipflop_pre()
Dflipflop_rst_pre()
