cmake_minimum_required(VERSION 3.18)
project(Cosim_tensor C CXX)

# Create executable for tensor cosimulation tests
add_executable(cosim_tensor cosim_tensor.cpp)

# Link against the Vtensor_9x9 library created in src/tensor
target_link_libraries(cosim_tensor PRIVATE
    Vtensor_9x9
    Vtensor_28x28
    Boost::system
    Boost::unit_test_framework
)

# Include directories for Verilator and tensor headers
target_include_directories(cosim_tensor PRIVATE
    ${VERILATOR_ROOT}/include
    ${CMAKE_SOURCE_DIR}/src/tensor
    ${PROJECT_BINARY_DIR}
)

target_compile_features(cosim_tensor PRIVATE cxx_std_23)

# Define BOOST_TEST_DYN_LINK for dynamic linking with Boost Test
target_compile_definitions(cosim_tensor PRIVATE BOOST_TEST_DYN_LINK)
