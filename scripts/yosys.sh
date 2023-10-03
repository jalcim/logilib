#!/bin/sh

rm -rf synth
yosys -v 99 -q -c scripts/yosys/all.tcl
#yosys -v 99 -q -c scripts/yosys/all.tcl 2 32
