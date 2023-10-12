yosys -import

proc make_dir {PATH} {
  file mkdir synth/$PATH/verilog \
    synth/$PATH/spice \
    synth/$PATH/rtlil
}

proc build_synth_wire {PATH NAME WIRE} {
    read_verilog src/$PATH/$NAME.v

    if {$NAME != "add"} {
	chparam -set "WIRE" $WIRE $NAME
    }

    set new_name ${NAME}_$WIRE
    general $PATH $NAME $new_name
}

proc general {PATH NAME NEW_NAME} {
    hierarchy -check
    flatten
#    peepopt
#    opt_expr
#    opt_demorgan
#    opt_clean
    clean
#    opt -fast
#    abc -fast
    check

    renames $NAME $NEW_NAME
    write_verilog -noattr -norename synth/$PATH/verilog/$NEW_NAME.v
    write_spice synth/$PATH/spice/$NEW_NAME.sp
    write_rtlil synth/$PATH/rtlil/$NEW_NAME.rtlil
    design -reset
}
