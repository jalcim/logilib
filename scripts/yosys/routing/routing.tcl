proc synth_mux {PATH WAY WIRE} {
    set NAME "mux"
    set SIZE_CTRL [expr $WAY - 1]

    read_verilog src/$PATH/$NAME.v
    puts $SIZE_CTRL
    chparam -set "SIZE_CTRL" $SIZE_CTRL $NAME
    chparam -set "WIRE" $WIRE $NAME

    general $PATH $NAME
}

proc synth_demux {PATH WAY WIRE} {
    set NAME "demux"
    set SIZE_CTRL [expr $WAY - 1]

    read_verilog src/$PATH/$NAME.v
    chparam -set "SIZE_CTRL" $SIZE_CTRL $NAME
    chparam -set "WIRE" $WIRE $NAME

    general $PATH $NAME
}

proc synth_replicator {PATH WAY WIRE} {
    set NAME "replicator"

    read_verilog src/$PATH/$NAME.v
    chparam -set "WAY" $WAY $NAME
    chparam -set "WIRE" $WIRE $NAME

    general $PATH $NAME
}

proc synth_shuffle {PATH WAY WIRE} {
    set NAME "shuffle"

    read_verilog src/$PATH/$NAME.v
    chparam -set "WAY" $WAY $NAME
    chparam -set "WIRE" $WIRE $NAME

    general $PATH $NAME
}

proc synth_routing {WAY WIRE} {
    set PATH "routing"

    make_dir $PATH

    synth_mux $PATH $WAY $WIRE
    synth_demux $PATH $WAY $WIRE
    synth_replicator $PATH $WAY $WIRE
    synth_shuffle $PATH $WAY $WIRE
}
