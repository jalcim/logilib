#!/bin/sh

mkdir bin
iverilog -o bin/multi_and src/multi_and.v test/test_multi_and.v
iverilog -o bin/multi_nand src/multi_nand.v test/test_multi_nand.v
iverilog -o bin/multi_or src/multi_or.v test/test_multi_or.v
iverilog -o bin/multi_nor src/multi_nor.v test/test_multi_nor.v
iverilog -o bin/multi_xor src/multi_xor.v test/test_multi_xor.v
iverilog -o bin/multi_xnor src/multi_xnor.v test/test_multi_xnor.v
iverilog -o bin/multi_xnor2 src/multi_xnor2.v test/test_multi_xnor.v
