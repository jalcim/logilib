proc synth_cpt_bin {PATH WIRE} {
    set NAME "cpt_bin"

    read_verilog src/$PATH/$NAME.v
    chparam -set "SIZE" $WIRE $NAME

    general $PATH $NAME
    
}

proc synth_compteur {WAY WIRE} {
    set PATH "compteur"

    make_dir $PATH

   synth_cpt_bin $PATH $WIRE
}
