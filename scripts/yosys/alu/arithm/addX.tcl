proc m_synth_addX {} {
    read_verilog src/alu/arithm/addX.v

    hierarchy -check -top addX
    check

    write_verilog synth/alu/arithm/verilog/addX.v
    write_spice synth/alu/arithm/spice/addX.sp
    write_rtlil synth/alu/arithm/rtlil/addX.rtlil
}

yosys -import
m_synth_addX
