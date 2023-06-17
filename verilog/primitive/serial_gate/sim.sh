#!/bin/sh

mkdir bin
iverilog -o bin/serial_and src/serial_and.v test/test_serial_and.v
iverilog -o bin/serial_nand src/serial_nand.v test/test_serial_nand.v
iverilog -o bin/serial_or src/serial_or.v test/test_serial_or.v
iverilog -o bin/serial_nor src/serial_nor.v test/test_serial_nor.v
iverilog -o bin/serial_xor src/serial_xor.v test/test_serial_xor.v
iverilog -o bin/serial_xnor src/serial_xnor.v test/test_serial_xnor.v
