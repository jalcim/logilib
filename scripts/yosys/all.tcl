set alu_file "scripts/yosys/alu/alu.tcl"
source $alu_file

proc synth_compteur {} {

}

proc synth_memory {} {
    
}

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

yosys -import
#puts $argc
#puts $argv0

#puts $argv1
puts [lindex $argv 0]

#synth_alu
#synth_compteur
#synth_memory
#synth_primitive
#synth_routing
