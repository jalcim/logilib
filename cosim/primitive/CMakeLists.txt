#if (ENABLE_COSIM_PRIMITIVE)
#    add_library(cosim_primitive primitive.cpp)

#    target_include_directories(cosim_primitive
#        PUBLIC ${CMAKE_CURRENT_SOURCE_DIR}
#    )

if (ENABLE_COSIM_PRIMITIVE_GATE)
  add_subdirectory(gate)
endif()
#endif()

#project(Cosim_primitives C CXX)

#add_subdirectory(gate)
#add_subdirectory(parallel_gate)
#add_subdirectory(serial_gate)

#add_library(${PROJECT_NAME} STATIC)

#target_link_libraries(${PROJECT_NAME} LINK_PUBLIC Cosim_gates Boost::log)

#target_sources(${PROJECT_NAME} PRIVATE ./primitive.cpp)

#target_include_directories(${PROJECT_NAME}
#  PRIVATE
#    ${CMAKE_CURRENT_SOURCE_DIR}/gate
#  PUBLIC
#    # where top-level project will look for the library's public headers
#    $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}>
#    # where external projects will look for the library's public headers
#    $<INSTALL_INTERFACE:${CMAKE_INSTALL_INCLUDEDIR}>
#)
