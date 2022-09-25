#!/bin/sh

iverilog -o test_gate \
	 cmos/serial_nmos.v cmos/serial_pmos.v \
	 gate/src/gate_nand.v gate/src/gate_nor.v gate/src/gate_not.v \
	 gate/test/test_gate.v
./test_gate
rm test_gate
mkdir signal
mv signal_gate.vcd signal/
