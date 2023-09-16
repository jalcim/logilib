#!/bin/sh

Dlatch ()
{
    TEST_Dlatch="test/memory/Dlatch"
    BIN_Dlatch="bin/memory/Dlatch"

    mkdir -p $BIN_Dlatch

    iverilog -o $BIN_Dlatch/test_Dlatch $TEST_Dlatch/test_Dlatch.v
    iverilog -o $BIN_Dlatch/test_serial_Dlatch $TEST_Dlatch/test_serial_Dlatch.v
#    iverilog -o $BIN_Dlatch/test_parallel_Dlatch $TEST_Dlatch/test_parallel_Dlatch.v

}

Dlatch
