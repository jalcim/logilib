add_library(Vbru STATIC)

target_include_directories(Vbru PUBLIC ${VERILATOR_ROOT}/include)

target_compile_features(Vgate PUBLIC cxx_std_20)

verilate(Vbru SOURCES bru.v TOP_MODULE bru)
