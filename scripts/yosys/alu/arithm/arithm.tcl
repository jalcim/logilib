proc synth_add {PATH} {
    set NAME "add"

    read_verilog src/$PATH/$NAME.v

    general $PATH $NAME
}

proc synth_addX {PATH WIRE} {
    set NAME "addX"

    read_verilog src/$PATH/$NAME.v
    chparam -set "WIRE" $WIRE $NAME

    general $PATH $NAME
}

proc synth_add_sub {PATH WIRE} {
    set NAME "add_sub"

    read_verilog src/$PATH/$NAME.v
    chparam -set "WIRE" $WIRE $NAME

    general $PATH $NAME
}

proc synth_cmp {PATH WIRE} {
    set NAME "cmp"

    read_verilog src/$PATH/$NAME.v
    chparam -set "WIRE" $WIRE $NAME

    general $PATH $NAME
}

proc synth_divmod2 {PATH WIRE} {
    set NAME "divmod2"

    read_verilog src/$PATH/$NAME.v
    chparam -set "WIRE" $WIRE $NAME

    general $PATH $NAME
}

proc synth_multX {PATH WIRE} {
    set NAME "multX"

    read_verilog src/$PATH/$NAME.v
    chparam -set "WIRE" $WIRE $NAME

    general $PATH $NAME
}

proc synth_arithm {WAY WIRE} {
    set PATH "alu/arithm"
    
    make_dir $PATH

    synth_add $PATH
    synth_addX $PATH $WIRE
    synth_add_sub $PATH $WIRE
    synth_cmp $PATH $WIRE
    synth_divmod2 $PATH $WIRE
    synth_multX $PATH $WIRE
}
