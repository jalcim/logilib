#!/bin/sh

test_routing()
{
    TEST_routing="test/routing"
    BIN_routing="bin/routing"

    mkdir -p $BIN_routing

#    iverilog -o $BIN_routing/test_decalleur_LR $TEST_routing/test_decalleur_LR.v

    iverilog -o $BIN_routing/test_demux $TEST_routing/test_demux.v
    iverilog -o $BIN_routing/test_demux8 $TEST_routing/test_demux8.v

    iverilog -o $BIN_routing/test_mux $TEST_routing/test_mux.v
    iverilog -o $BIN_routing/test_mux8 $TEST_routing/test_mux8.v
}

test_routing
