set Dlatch_file "scripts/yosys/memory/Dlatch/Dlatch.tcl"
#set Dflipflop_file "scripts/yosys/memory/Dflipflop/Dflipflop.tcl"
#set JKlatch_file "scripts/yosys/memory/JKlatch/JKlatch.tcl"

source $Dlatch_file
#source $Dflipflop
#source $JKlatch

proc synth_memory {WAY WIRE} {
    synth_Dlatch_all $WAY $WIRE    
#    synth_Dflipflop $WAY $WIRE
#    synth_JKlatch $WAY $WIRE
}
