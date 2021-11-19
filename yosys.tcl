proc m_read_primitive {} {
    read_verilog primitive/src/gate.v
    read_verilog primitive/src/gate8.v
    read_verilog primitive/src/multigate.v
}

proc m_read_routing {} {
    read_verilog routing/src/multiplexeur.v
}

proc m_synth_intel {} {
    synth_intel -family cyclonev -vqm out.v
}

yosys -import
m_read_primitive
m_read_routing
m_synth_intel
