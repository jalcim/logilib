set alu_file "scripts/yosys/alu/alu.tcl"
set compteur_file "scripts/yosys/compteur/compteur.tcl"
set memory_file "scripts/yosys/memory/memory.tcl"
set primitive_file "scripts/yosys/primitive/primitive.tcl"
set routing_file "scripts/yosys/routing/routing.tcl"

source $alu_file
source $compteur_file
source $memory_file
source $primitive_file
source $routing_file

proc general {PATH NAME} {
#    hierarchy -check -top $NAME
    check

    write_verilog synth/$PATH/verilog/$NAME.v
    write_spice synth/$PATH/spice/$NAME.sp
    write_rtlil synth/$PATH/rtlil/$NAME.rtlil
    design -reset
}

proc make_dir {PATH} {
    file mkdir synth/$PATH/verilog \
	synth/$PATH/spice \
	synth/$PATH/rtlil
}

yosys -import

set WAY  2
set WIRE 32
#set WAY  $argv4
#set WIRE $argv5
#set WAY [lindex $argv 0]
#set WIRE [lindex $argv 0]

synth_alu $WAY $WIRE
synth_compteur $WAY $WIRE
synth_memory $WAY $WIRE
synth_primitive $WAY $WIRE
synth_routing $WAY $WIRE
