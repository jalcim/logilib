target_sources(VDlatch-tests PRIVATE Dlatch.cpp Dlatch-utils.cpp main-tests.cpp)

target_include_directories(VDlatch-tests PRIVATE ${CMAKE_CURRENT_SOURCE_DIR})

target_link_libraries(VDlatch-tests PRIVATE Boost::system Boost::unit_test_framework VDlatch)

target_compile_features(VDlatch-tests PRIVATE cxx_std_20)
