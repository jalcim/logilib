proc synth_Dlatch_rst {PATH WAY WIRE} {
    set NAME "Dlatch_rst"

    read_verilog src/$PATH/$NAME.v

    general $PATH $NAME
}

proc synth_Dlatch {PATH WAY WIRE} {
    set NAME "Dlatch"

    read_verilog src/$PATH/$NAME.v

    general $PATH $NAME
}

proc synth_Dlatch_all {WAY WIRE} {
    set PATH "memory/Dlatch"

    make_dir $PATH

    synth_Dlatch_rst $PATH $WAY $WIRE
    synth_Dlatch $PATH $WAY $WIRE
}
