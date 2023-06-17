proc m_synth_and {} {
    read_verilog src/multi_and.v
    synth
    write_verilog synth/verilog/synth_multi_and.v
    write_spice synth/spice/synth_multi_and.spice
}

proc m_synth_nand {} {
    read_verilog src/multi_nand.v
    synth
    write_verilog synth/verilog/synth_multi_nand.v
    write_spice synth/spice/synth_multi_nand.spice
}

proc m_synth_nor {} {
    read_verilog src/multi_nor.v
    synth
    write_verilog synth/verilog/synth_multi_nor.v
    write_spice synth/spice/synth_multi_nor.spice
}

proc m_synth_or {} {
    read_verilog src/multi_or.v
    synth
    write_verilog synth/verilog/synth_multi_or.v
    write_spice synth/spice/synth_multi_or.spice
}

proc m_synth_xnor {} {
    read_verilog src/multi_xnor.v
    synth
    write_verilog synth/verilog/synth_multi_xnor.v
    write_spice synth/spice/synth_multi_xnor.spice
}

proc m_synth_xor {} {
    read_verilog src/multi_xor.v
    synth
    write_verilog synth/verilog/synth_multi_xor.v
    write_spice synth/spice/synth_multi_xor.spice
}

yosys -import

m_synth_and
m_synth_nand
m_synth_nor
m_synth_or
m_synth_xnor
m_synth_xor
