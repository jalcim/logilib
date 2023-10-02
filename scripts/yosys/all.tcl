set alu_file "scripts/yosys/alu/alu.tcl"
set compteur_file "scripts/yosys/compteur/compteur.tcl"
set memory_file "scripts/yosys/memory/memory.tcl"

source $alu_file
source $compteur_file
source $memory_file

proc synth_primitive {} {

}

proc synth_routing {} {

}

proc general {PATH NAME} {
    hierarchy -check -top $NAME
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
puts $argc
puts $argv0
puts $argv1
puts $argv2

#puts [lindex $argv 0]

synth_alu $argv1 $argv2
synth_compteur $argv1 $argv2
synth_memory $argv1 $argv2
#synth_primitive
#synth_routing
