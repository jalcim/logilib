#!/bin/sh

test_routing()
{
    TEST_routing="test/routing"
    BIN_routing="bin/routing"

    mkdir -p $BIN_routing

    iverilog -o $BIN_routing/test_decalleur_LR $TEST_routing/test_decalleur_LR.v
}

test_routing
