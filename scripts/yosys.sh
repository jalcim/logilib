#!/bin/sh

rm -rf synth
~/tools/yosys/yosys -q -c scripts/yosys/all.tcl 2 32
