cmake_minimum_required(VERSION 3.18)
project(Cosim_tensor C CXX)

# Create executable for tensor cosimulation tests
add_executable(cosim_tensor main.cpp cosim_tensor_9x9.cpp cosim_tensor_28x28.cpp)

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

# Configure CNN with Ninja to build in the main build directory
execute_process(
    COMMAND cmake -S ${CMAKE_CURRENT_SOURCE_DIR}/cnn -B ${CMAKE_BINARY_DIR}/cosim/tensor/cnn -GNinja
    WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}
    RESULT_VARIABLE CNN_CONFIG_RESULT
)

# Custom target to build CNN
add_custom_target(build_cnn ALL
    COMMAND cmake --build ${CMAKE_BINARY_DIR}/cosim/tensor/cnn
    WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}
    COMMENT "Building CNN project with Ninja"
)

# Ensure the cosim/tensor/cnn directory exists in the main build
file(MAKE_DIRECTORY ${CMAKE_BINARY_DIR}/cosim/tensor/cnn)

# Target pour exécuter le CNN avec le bon répertoire de travail
add_custom_target(run_cnn
    COMMAND ${CMAKE_BINARY_DIR}/cosim/tensor/cnn/CNN
    WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}/cnn
    DEPENDS build_cnn
    COMMENT "Exécution du CNN avec le dataset"
    VERBATIM
)
