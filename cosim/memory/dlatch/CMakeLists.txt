function(cosim_VDlatch)
  add_executable(VDlatch-tests)
  target_sources(VDlatch-tests PRIVATE
    Dlatch-utils.cpp main-tests.cpp
    Dlatch.cpp Dlatch_rst.cpp Dlatch_pre.cpp Dlatch_rst_pre.cpp)
    
  target_include_directories(VDlatch-tests PRIVATE ${CMAKE_CURRENT_SOURCE_DIR})
  target_link_libraries(VDlatch-tests PRIVATE Boost::system Boost::unit_test_framework
    VDlatch VDlatch_rst VDlatch_pre VDlatch_rst_pre)

  target_compile_features(VDlatch-tests PRIVATE cxx_std_20)
endfunction ()

cosim_VDlatch()
