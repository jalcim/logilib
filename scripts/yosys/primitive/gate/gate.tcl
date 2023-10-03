proc synth_gate_buf {PATH WIRE} {
    set NAME "gate_buf"

    read_verilog src/$PATH/$NAME.v
    chparam -set "WIRE" $WIRE $NAME

    general $PATH $NAME
}

proc synth_gate_not {PATH WIRE} {
    set NAME "gate_not"

    read_verilog src/$PATH/$NAME.v
    chparam -set "WIRE" $WIRE $NAME

    general $PATH $NAME
}

proc synth_gate_and {PATH WAY WIRE} {
    set NAME "gate_and"

    read_verilog src/$PATH/$NAME.v
    chparam -set "WAY" $WAY $NAME
    chparam -set "WIRE" $WIRE $NAME

    general $PATH $NAME
}

proc synth_gate_nand {PATH WAY WIRE} {
    set NAME "gate_nand"

    read_verilog src/$PATH/$NAME.v
    chparam -set "WAY" $WAY $NAME
    chparam -set "WIRE" $WIRE $NAME

    general $PATH $NAME
}

proc synth_gate_or {PATH WAY WIRE} {
    set NAME "gate_or"

    read_verilog src/$PATH/$NAME.v
    chparam -set "WAY" $WAY $NAME
    chparam -set "WIRE" $WIRE $NAME

    general $PATH $NAME
}

proc synth_gate_nor {PATH WAY WIRE} {
    set NAME "gate_nor"

    read_verilog src/$PATH/$NAME.v
    chparam -set "WAY" $WAY $NAME
    chparam -set "WIRE" $WIRE $NAME

    general $PATH $NAME
}

proc synth_gate_xor {PATH WAY WIRE} {
    set NAME "gate_xor"

    read_verilog src/$PATH/$NAME.v
    chparam -set "WAY" $WAY $NAME
    chparam -set "WIRE" $WIRE $NAME

    general $PATH $NAME
}

proc synth_gate_xnor {PATH WAY WIRE} {
    set NAME "gate_xnor"

    read_verilog src/$PATH/$NAME.v
    chparam -set "WAY" $WAY $NAME
    chparam -set "WIRE" $WIRE $NAME

    general $PATH $NAME
}

proc synth_gate {WAY WIRE} {
    set PATH "primitive/gate"

    make_dir $PATH

    synth_gate_buf  $PATH $WIRE
    synth_gate_not  $PATH $WIRE
    synth_gate_and  $PATH $WAY $WIRE
    synth_gate_nand $PATH $WAY $WIRE
    synth_gate_or   $PATH $WAY $WIRE
    synth_gate_nor  $PATH $WAY $WIRE
    synth_gate_xor  $PATH $WAY $WIRE
    synth_gate_xnor $PATH $WAY $WIRE
}
