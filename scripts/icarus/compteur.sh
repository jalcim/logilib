#!/bin/sh

test_compteur()
{
    TEST_compteur="test/compteur"
    BIN_compteur="bin/compteur"

    mkdir -p $BIN_compteur

    iverilog -o $BIN_compteur/test_cpt_bin $TEST_compteur/test_cpt_bin.v
#    iverilog -o $BIN_compteur/test_bit_cpt3 $TEST_compteur/test_bit_cpt3.v
}

test_compteur
