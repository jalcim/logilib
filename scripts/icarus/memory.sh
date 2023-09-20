#!/bin/sh

test_Dlatch ()
{
    TEST_Dlatch="test/memory/Dlatch"
    BIN_Dlatch="bin/memory/Dlatch"

    mkdir -p $BIN_Dlatch

    iverilog -o $BIN_Dlatch/test_Dlatch $TEST_Dlatch/test_Dlatch.v
    iverilog -o $BIN_Dlatch/test_serial_Dlatch $TEST_Dlatch/test_serial_Dlatch.v
#    iverilog -o $BIN_Dlatch/test_parallel_Dlatch $TEST_Dlatch/test_parallel_Dlatch.v

    iverilog -o $BIN_Dlatch/test_Dlatch_rst $TEST_Dlatch/test_Dlatch_rst.v
    iverilog -o $BIN_Dlatch/test_serial_Dlatch_rst $TEST_Dlatch/test_serial_Dlatch_rst.v
}

test_Dflipflop ()
{
    TEST_Dflipflop="test/memory/Dflipflop"
    BIN_Dflipflop="bin/memory/Dflipflop"

    mkdir -p $BIN_Dflipflop

    iverilog -o $BIN_Dflipflop/test_Dflipflop $TEST_Dflipflop/test_Dflipflop.v
}

test_JKlatch ()
{
    TEST_JKlatch="test/memory/JKlatch"
    BIN_JKlatch="bin/memory/JKlatch"

    mkdir -p $BIN_JKlatch

    iverilog -o $BIN_JKlatch/test_JKlatchUP_rst $TEST_JKlatch/test_JKlatchUP_rst.v
    iverilog -o $BIN_JKlatch/test_serial_JKlatchUP_rst $TEST_JKlatch/test_serial_JKlatchUP_rst.v
}

test_Dlatch
test_Dflipflop
test_JKlatch
