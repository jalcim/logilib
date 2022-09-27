proc m_read {} {
    read_verilog cmos/serial_nmos.v
    read_verilog cmos/serial_pmos.v
    read_verilog gate/src/gate_nand.v
}

yosys -import
m_read
hierarchy
synth
write_verilog out.v
write_spice out.spice
