target_sources(Vbru-tests PRIVATE bru-tests.cpp bru-utils.cpp main-tests.cpp)
target_include_directories(Vbru-tests PRIVATE ${CMAKE_CURRENT_SOURCE_DIR} ${VERILATOR_ROOT}/include)
target_link_libraries(Vbru-tests PRIVATE Boost::system Boost::unit_test_framework Vbru)#boost_unit_test_framework Vbru)
target_compile_features(Vbru-tests PRIVATE cxx_std_20)
