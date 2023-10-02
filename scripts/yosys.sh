#!/bin/sh

rm -rf synth
yosys -c scripts/yosys/all.tcl lalala caca
#yosys -p 'tcl scripts/yosys/all.tcl lalala caca'
