cmake_minimum_required(VERSION 3.23)

project(logilib)
    option(ENABLE_VCD "Enable VCD trace file generation" Off)
    option(STATIC_BUILD "Compiles into one binary with no dynamic dependencies" Off)
    option(TESTS "Enable unit testing" On)
    set(LOG_LEVEL "trace" CACHE STRING "Set the log level")
    set(MAX_WAYS "8" CACHE STRING "Max number of gates ways generated")
    set(VERILATOR_TIME_STEP "1000" CACHE STRING "Time between each verilator evaluations")

    set(Boost_USE_STATIC_LIBS       OFF) # only find static libs
    set(Boost_USE_DEBUG_LIBS        OFF) # ignore debug libs and
    set(Boost_USE_RELEASE_LIBS      ON)  # only find release libs
    set(Boost_USE_MULTITHREADED     ON)
    set(Boost_USE_STATIC_RUNTIME    OFF)

    if (STATIC_BUILD)
        set(CMAKE_FIND_LIBRARY_SUFFIXES ".a")
        set(BUILD_SHARED_LIBS OFF)
        set(CMAKE_EXE_LINKER_FLAGS "-static")
        set(Boost_USE_STATIC_LIBS on)  # only find static libs
    endif()

    find_package(Boost 1.74.0 REQUIRED COMPONENTS log log_setup system unit_test_framework)
    find_package(verilator REQUIRED HINTS $ENV{VERILATOR_ROOT} ${VERILATOR_ROOT})
#    verilator_generate_key(PROTECT_KEY)

    function(add_gate)
        cmake_parse_arguments(PARSE_ARGV 0 GATE
            "WAYS" "TARGET;NAME;WAY" ""
        )

        set (GATE_ARGS ${VERILATOR_ARGS})
        if (${GATE_WAYS})
            set (GATE_ARGS ${GATE_ARGS} -GWAY=${GATE_WAY})
        endif()

        message(STATUS "Adding a gate ${GATE_NAME} to target ${GATE_TARGET}")
        verilate(${GATE_TARGET}
            INCLUDE_DIRS ${CMAKE_SOURCE_DIR}
            SOURCES gate_${GATE_NAME}.v
            TOP_MODULE gate_${GATE_NAME}
            VERILATOR_ARGS ${GATE_ARGS}
            PREFIX Vgate_${GATE_NAME}_${GATE_WAY}
        )

        if (TESTS)
            configure_file(gate-tests.cpp.in Vgate_${GATE_NAME}_${GATE_WAY}-tests.cpp)
            target_sources(${GATE_TARGET}-tests PRIVATE
                ${CMAKE_CURRENT_BINARY_DIR}/Vgate_${GATE_NAME}_${GATE_WAY}-tests.cpp
            )
        endif()
    endfunction()

    #add_subdirectory(cosim)
    add_subdirectory(src)
