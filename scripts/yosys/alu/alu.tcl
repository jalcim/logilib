set arithm_file "scripts/yosys/alu/arithm/arithm.tcl"
source $arithm_file

proc synth_alu {} {
    synth_arithm
#    synth_logic
}
