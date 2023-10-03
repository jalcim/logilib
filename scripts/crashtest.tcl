yosys -import

set WAY  2
set WIRE 32

set PATH "memory/Dlatch"
set NAME "Dlatch_rst"

read_verilog src/$PATH/$NAME.v
chparam -set "WAY" $WAY $NAME
chparam -set "WIRE" $WIRE $NAME

hierarchy -check -top $NAME
check

write_verilog synth/$PATH/verilog/$NAME.v
write_spice synth/$PATH/spice/$NAME.sp
write_rtlil synth/$PATH/rtlil/$NAME.rtlil
