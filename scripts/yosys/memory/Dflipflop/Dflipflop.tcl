proc synth_Dflipflop {PATH NAME WAY WIRE} {
    read_verilog src/$PATH/$NAME.v
    chparam -set "WAY" $WAY $NAME
    chparam -set "WIRE" $WIRE $NAME

    general $PATH $NAME
}

proc synth_Dflipflop_all {WAY WIRE} {
    set PATH "memory/dflipflop"

    make_dir $PATH

    synth_Dflipflop $PATH "Dflipflop" $WAY $WIRE
    synth_Dflipflop $PATH "Dflipflop_rst" $WAY $WIRE
    synth_Dflipflop $PATH "Dflipflop_pre" $WAY $WIRE
    synth_Dflipflop $PATH "Dflipflop_rst_pre" $WAY $WIRE
}
