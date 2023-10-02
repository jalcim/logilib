proc synth_sll {PATH WIRE} {
    set NAME "sll"

    read_verilog src/$PATH/$NAME.v
    chparam -set "WIRE" $WIRE $NAME

    general $PATH $NAME
}

proc synth_sltu {PATH WIRE} {
    set NAME "sltu"

    read_verilog src/$PATH/$NAME.v
    chparam -set "WIRE" $WIRE $NAME

    general $PATH $NAME
}

proc synth_slt {PATH WIRE} {
    set NAME "slt"

    read_verilog src/$PATH/$NAME.v
    chparam -set "WIRE" $WIRE $NAME

    general $PATH $NAME
}

proc synth_sra_srl {PATH WIRE} {
    set NAME "sra_srl"

    read_verilog src/$PATH/$NAME.v
    chparam -set "WIRE" $WIRE $NAME

    general $PATH $NAME
}

proc synth_logic {WAY WIRE} {
    set PATH "alu/logic"
    
    make_dir $PATH

    synth_sll $PATH $WIRE
    synth_sltu $PATH $WIRE
    synth_slt $PATH $WIRE
    synth_sra_srl $PATH $WIRE
}
