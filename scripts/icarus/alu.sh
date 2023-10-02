#!/bin/sh

test_alu_arithm()
{
    TEST_alu_arithm="test/alu/arithm"
    BIN_alu_arithm="bin/alu/arithm"

    mkdir -p $BIN_alu_arithm

    iverilog -o $BIN_alu_arithm/test_add $TEST_alu_arithm/test_add.v
    iverilog -o $BIN_alu_arithm/test_addX $TEST_alu_arithm/test_addX.v
    iverilog -o $BIN_alu_arithm/test_add8 $TEST_alu_arithm/test_add8.v
    iverilog -o $BIN_alu_arithm/test_divmod2 $TEST_alu_arithm/test_divmod2.v
    iverilog -o $BIN_alu_arithm/test_multX $TEST_alu_arithm/test_multX.v
    iverilog -o $BIN_alu_arithm/test_cmp $TEST_alu_arithm/test_cmp.v
}

test_alu_logic()
{
    TEST_alu_logic="test/alu/logic"
    BIN_alu_logic="bin/alu/logic"

    mkdir -p $BIN_alu_logic

    iverilog -o $BIN_alu_logic/test_alu_logic $TEST_alu_logic/test_alu_logic.v
}

test_alu()
{
    test_alu_arithm
    test_alu_logic
}

test_alu
