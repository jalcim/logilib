#!/bin/sh

mkdir -p synth/alu/arithm/verilog
mkdir -p synth/alu/arithm/spice
mkdir -p synth/alu/arithm/rtlil

yosys -c scripts/yosys/alu/arithm/addX.tcl
