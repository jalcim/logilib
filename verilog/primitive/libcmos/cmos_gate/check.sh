#!/bin/sh

mkdir bin

iverilog src/* test/test_gate.v ../cmos/src/* -o bin/eval_gate
