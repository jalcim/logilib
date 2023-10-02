cmake_minimum_required(VERSION 3.18)
project(Vmain C CXX)

include(environment)

INIT_ENVIRONMENT()

add_subdirectory(primitive)

add_executable(${PROJECT_NAME})

target_link_libraries(${PROJECT_NAME} LINK_PUBLIC Cosim_primitives ${Boost_LIBRARIES})

target_sources(${PROJECT_NAME} PRIVATE ./main.cpp)
