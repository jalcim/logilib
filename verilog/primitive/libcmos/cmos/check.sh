#!/bin/sh
mkdir bin

iverilog src/nmos.v test/test_nmos.v -o bin/eval_nmos
iverilog src/pmos.v test/test_pmos.v -o bin/eval_pmos

iverilog src/parallel_nmos.v test/test_parallel_nmos.v src/nmos.v -o bin/eval_parallel_nmos
iverilog src/parallel_pmos.v test/test_parallel_pmos.v src/pmos.v -o bin/eval_parallel_pmos

iverilog src/serial_nmos.v test/test_serial_nmos.v src/nmos.v -o bin/eval_serial_nmos
iverilog src/serial_pmos.v test/test_serial_pmos.v src/pmos.v -o bin/eval_serial_pmos
