if (ENABLE_COSIM)
    add_executable(cosim main.cpp)

    target_link_libraries(cosim PUBLIC Boost::log Boost::log_setup Vgate)

    target_compile_features(cosim PUBLIC cxx_std_20)

    target_include_directories(cosim
        PUBLIC ${CMAKE_SOURCE_DIR}
    )

    target_compile_definitions(cosim
        PRIVATE
        "$<$<BOOL:${ENABLE_VCD}>:VCD_TRACE_ENABLED>"
        "$<$<BOOL:${LOG_LEVEL}>:LOG_LEVEL=${LOG_LEVEL}>"
        "$<$<BOOL:${STATIC_BUILD}>:BOOST_LOG_DYN_LINK>"
        "VERILATOR_TIME_STEP=${VERILATOR_TIME_STEP}"
    )

    if (ENABLE_COSIM_PRIMITIVE)
        add_subdirectory(primitive)
    endif()
endif()
