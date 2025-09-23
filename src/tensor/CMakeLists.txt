execute_process(
  COMMAND yosys -p "read_verilog -I${CMAKE_SOURCE_DIR}/src/tensor ${CMAKE_SOURCE_DIR}/src/tensor/tensor.v; hierarchy -chparam IMG_MAX_Y 9 -chparam IMG_MAX_X 9 -chparam CONV_MAX_Y 3 -chparam CONV_MAX_X 3 -top tensor; write_verilog ${CMAKE_CURRENT_BINARY_DIR}/synth_9x9.v"
  WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
)

add_library(Vtensor_9x9 STATIC)
target_include_directories(Vtensor_9x9 PUBLIC ${VERILATOR_ROOT}/include)
target_compile_features(Vtensor_9x9 PUBLIC cxx_std_23)

verilate(Vtensor_9x9
  INCLUDE_DIRS ${CMAKE_SOURCE_DIR}
  SOURCES ${CMAKE_CURRENT_BINARY_DIR}/synth_9x9.v
  TOP_MODULE tensor
  VERILATOR_ARGS --trace
)

############################################################

execute_process(
  COMMAND yosys -p "read_verilog -I${CMAKE_SOURCE_DIR}/src/tensor ${CMAKE_SOURCE_DIR}/src/tensor/tensor.v; hierarchy -chparam IMG_MAX_Y 28 -chparam IMG_MAX_X 28 -chparam CONV_MAX_Y 3 -chparam CONV_MAX_X 3 -top tensor; write_verilog ${CMAKE_CURRENT_BINARY_DIR}/synth_28x28.v"
  WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
)

add_library(Vtensor_28x28 STATIC)
target_include_directories(Vtensor_28x28 PUBLIC ${VERILATOR_ROOT}/include)
target_compile_features(Vtensor_28x28 PUBLIC cxx_std_23)

verilate(Vtensor_28x28
  INCLUDE_DIRS ${CMAKE_SOURCE_DIR}
  SOURCES ${CMAKE_CURRENT_BINARY_DIR}/synth_28x28.v
  TOP_MODULE tensor
  VERILATOR_ARGS --trace
)
