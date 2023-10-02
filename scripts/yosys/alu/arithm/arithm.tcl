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

proc synth_arithm {} {
    set PATH "alu/arithm"
    
    file mkdir synth/$PATH/verilog \
	synth/$PATH/spice \
	synth/$PATH/rtlil

    synth_add $PATH 
    synth_addX $PATH 32
    synth_add_sub $PATH 32
    synth_cmp $PATH 32
    synth_divmod2 $PATH 32
    synth_multX $PATH 32
}
