proc m_synth_and {} {
    read_verilog src/serial_and.v
    synth
    write_verilog synth/verilog/synth_serial_and.v
    write_spice synth/spice/synth_serial_and.spice
}

proc m_synth_nand {} {
    read_verilog src/serial_nand.v
    synth
    write_verilog synth/verilog/synth_serial_nand.v
    write_spice synth/spice/synth_serial_nand.spice
}

proc m_synth_nor {} {
    read_verilog src/serial_nor.v
    synth
    write_verilog synth/verilog/synth_serial_nor.v
    write_spice synth/spice/synth_serial_nor.spice
}

proc m_synth_or {} {
    read_verilog src/serial_or.v
    synth
    write_verilog synth/verilog/synth_serial_or.v
    write_spice synth/spice/synth_serial_or.spice
}

proc m_synth_xnor {} {
    read_verilog src/serial_xnor.v
    synth
    write_verilog synth/verilog/synth_serial_xnor.v
    write_spice synth/spice/synth_serial_xnor.spice
}

proc m_synth_xor {} {
    read_verilog src/serial_xor.v
    synth
    write_verilog synth/verilog/synth_serial_xor.v
    write_spice synth/spice/synth_serial_xor.spice
}

yosys -import

m_synth_and
m_synth_nand
m_synth_nor
m_synth_or
m_synth_xnor
m_synth_xor
