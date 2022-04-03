proc m_read_primitive {} {
    read_verilog primitive/src/gate.v
    read_verilog primitive/src/gate8.v
    read_verilog primitive/src/multigate.v
}

proc m_read_primitive_v2 {} {
    read_verilog logilib_V2/primitive/multi_and.v
}

proc m_read_routing {} {
    read_verilog routing/src/multiplexeur.v
}

proc m_synth_intel {} {
    synth_intel -family cyclonev -vqm out.v
}

proc m_synth {} {
    synth
    write_verilog out.v
}

yosys -import
#m_read_primitive
m_read_primitive_v2
#m_read_routing
#m_synth_intel
m_synth

