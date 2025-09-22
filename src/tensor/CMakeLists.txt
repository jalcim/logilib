# Create library for tensor modules
add_library(Vtensor STATIC)
target_include_directories(Vtensor PUBLIC ${VERILATOR_ROOT}/include)
target_compile_features(Vtensor PUBLIC cxx_std_20)

# Set verilator arguments
set(VERILATOR_ARGS -cc --exe -x-assign fast --trace --no-decoration --assert --coverage)

# List of tensor modules to compile (excluding mmul.v and test_*.v)
set(TENSOR_MODULES
  "adder_tree"
  "on_border"
  "on_center"
  "on_coin"
  "acc"
  "mult"
  "tensor"
)

# Generate verilated modules for each tensor component
foreach(module IN LISTS TENSOR_MODULES)
  message(STATUS "Adding tensor module ${module} to target Vtensor")
  verilate(Vtensor
    INCLUDE_DIRS ${CMAKE_SOURCE_DIR}
    SOURCES ${module}.v
    TOP_MODULE ${module}
    VERILATOR_ARGS ${VERILATOR_ARGS}
    PREFIX V${module}
  )
endforeach()

# Generate specific tensor configurations for testing
message(STATUS "Adding tensor_9x9 configuration to target Vtensor")
verilate(Vtensor
  INCLUDE_DIRS ${CMAKE_SOURCE_DIR}
  SOURCES tensor.v
  TOP_MODULE tensor
  VERILATOR_ARGS ${VERILATOR_ARGS} -GIMG_MAX_X=9 -GIMG_MAX_Y=9 -GCONV_MAX_X=3 -GCONV_MAX_Y=3
  PREFIX Vtensor_9x9
)

message(STATUS "Adding tensor_28x28 configuration to target Vtensor")
verilate(Vtensor
  INCLUDE_DIRS ${CMAKE_SOURCE_DIR}
  SOURCES tensor.v
  TOP_MODULE tensor
  VERILATOR_ARGS ${VERILATOR_ARGS} -GIMG_MAX_X=28 -GIMG_MAX_Y=28 -GCONV_MAX_X=3 -GCONV_MAX_Y=3
  PREFIX Vtensor_28x28
)
