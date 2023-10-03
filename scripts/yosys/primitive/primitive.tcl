set gate_file "scripts/yosys/primitive/gate/gate.tcl"
#set complex_gate_file "scripts/yosys/primitive/complex_gate.tcl"

source $gate_file
#source $complexe_gate_file

proc synth_primitive {WAY WIRE} {
    synth_gate $WAY $WIRE
#    synth_complex_gate $WAY $WIRE
}
