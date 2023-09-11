#!/bin/sh

mkdir -p synth/verilog synth/spice
yosys -c yosys.tcl
