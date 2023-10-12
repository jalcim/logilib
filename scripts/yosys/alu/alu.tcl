
set arithm_file "scripts/yosys/alu/arithm/arithm.tcl"
set logic_file "scripts/yosys/alu/logic/logic.tcl"

source $arithm_file
source $logic_file

proc synth_alu {WAY WIRE} {
    synth_arithm $WAY $WIRE
    synth_logic $WAY $WIRE
}
