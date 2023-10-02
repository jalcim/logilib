#!/bin/sh

PRIM_SRC="primitive/src"
ROUT_SRC="routing/src"
MEM_SRC="memory/src"
CPT_SRC="compteur/src"
ALU_ARITHM_SRC="alu/arithm/src"
ALU_MAIN_SRC="alu/alu/src"

PRIM_BUILD="build/primitive"
ROUT_BUILD="build/routing"
MEM_BUILD="build/memory"
CPT_BUILD="build/compteur"
ALU_ARITHM_BUILD="build/alu/arithm"
ALU_MAIN_BUILD="build/alu/alu"

PRIM_DEBUG="build/primitive/debug"
ROUT_DEBUG="build/routing/debug"
MEM_DEBUG="build/memory/debug"
CPT_DEBUG="build/compteur/debug"
ALU_ARITHM_DEBUG="build/alu/arithm/debug"
ALU_MAIN_DEBUG="build/alu/alu/debug"

PRIM_BIN="build/primitive/bin"
ROUT_BIN="build/routing/bin"
MEM_BIN="build/memory/bin"
CPT_BIN="build/compteur/bin"
ALU_ARITHM_BIN="build/alu/arithm/bin"
ALU_MAIN_BIN="build/alu/alu/bin"

compil_primitive()
{
    PRIM_TEST="primitive/test"

    iverilog -o $PRIM_BIN/not $PRIM_TEST/test_not.v $PRIM_SRC/gate.v
    iverilog -o $PRIM_BIN/buf $PRIM_TEST/test_buf.v $PRIM_SRC/gate.v
    iverilog -o $PRIM_BIN/and $PRIM_TEST/test_and.v $PRIM_SRC/gate.v
    iverilog -o $PRIM_BIN/nand $PRIM_TEST/test_nand.v $PRIM_SRC/gate.v
    iverilog -o $PRIM_BIN/or $PRIM_TEST/test_or.v $PRIM_SRC/gate.v
    iverilog -o $PRIM_BIN/nor $PRIM_TEST/test_nor.v $PRIM_SRC/gate.v
    iverilog -o $PRIM_BIN/xor $PRIM_TEST/test_xor.v $PRIM_SRC/gate.v
    iverilog -o $PRIM_BIN/xnor $PRIM_TEST/test_xnor.v $PRIM_SRC/gate.v

    iverilog -o $PRIM_BIN/and8 $PRIM_TEST/test_and8.v $PRIM_SRC/gate8.v $PRIM_SRC/gate.v

    iverilog -o $PRIM_BIN/recursive_buf $PRIM_SRC/recursive_gate.v $PRIM_TEST/test_recursive_buf.v  $PRIM_SRC/gate.v
    iverilog -o $PRIM_BIN/recursive_not $PRIM_SRC/recursive_gate.v $PRIM_TEST/test_recursive_not.v  $PRIM_SRC/gate.v
    iverilog -o $PRIM_BIN/recursive_and $PRIM_SRC/recursive_gate.v $PRIM_TEST/test_recursive_and.v  $PRIM_SRC/gate.v
    iverilog -o $PRIM_BIN/recursive_or $PRIM_SRC/recursive_gate.v $PRIM_TEST/test_recursive_or.v   $PRIM_SRC/gate.v
    iverilog -o $PRIM_BIN/recursive_xor $PRIM_SRC/recursive_gate.v $PRIM_TEST/test_recursive_xor.v  $PRIM_SRC/gate.v
    iverilog -o $PRIM_BIN/recursive_xnor $PRIM_SRC/recursive_gate.v $PRIM_TEST/test_recursive_xnor.v $PRIM_SRC/gate.v
    iverilog -o $PRIM_BIN/recursive_nand $PRIM_SRC/recursive_gate.v $PRIM_TEST/test_recursive_nand.v $PRIM_SRC/gate.v
    iverilog -o $PRIM_BIN/recursive_nor $PRIM_SRC/recursive_gate.v $PRIM_TEST/test_recursive_nor.v  $PRIM_SRC/gate.v
    
}

test_primitive()
{
    $PRIM_BIN/not  > $PRIM_DEBUG/not
    $PRIM_BIN/buf  > $PRIM_DEBUG/buf
    $PRIM_BIN/and  > $PRIM_DEBUG/and
    $PRIM_BIN/nand > $PRIM_DEBUG/nand
    $PRIM_BIN/or   > $PRIM_DEBUG/or
    $PRIM_BIN/nor  > $PRIM_DEBUG/nor
    $PRIM_BIN/xor  > $PRIM_DEBUG/xor
    $PRIM_BIN/xnor > $PRIM_DEBUG/xnor

    $PRIM_BIN/and8 > $PRIM_DEBUG/and8

    $PRIM_BIN/recursive_not  > $PRIM_DEBUG/recursive_not
    $PRIM_BIN/recursive_buf  > $PRIM_DEBUG/recursive_buf
    $PRIM_BIN/recursive_and  > $PRIM_DEBUG/recursive_and
    $PRIM_BIN/recursive_nand > $PRIM_DEBUG/recursive_nand
    $PRIM_BIN/recursive_or   > $PRIM_DEBUG/recursive_or
    $PRIM_BIN/recursive_nor  > $PRIM_DEBUG/recursive_nor
    $PRIM_BIN/recursive_xor  > $PRIM_DEBUG/recursive_xor
    $PRIM_BIN/recursive_xnor > $PRIM_DEBUG/recursive_xnor
}

compil_routing()
{
    ROUT_TEST="routing/test"

    iverilog -o $ROUT_BIN/mux_1x8 \
	     $PRIM_SRC/gate.v $PRIM_SRC/multigate.v $PRIM_SRC/gate8.v \
	     $ROUT_SRC/multiplexeur.v $ROUT_TEST/test_mux_1x8.v

    iverilog -o $ROUT_BIN/mux_8bitx2\
	     $PRIM_SRC/gate.v $PRIM_SRC/multigate.v $PRIM_SRC/gate8.v \
	     $ROUT_SRC/multiplexeur.v $ROUT_TEST/test_mux_8bitx2.v

    iverilog -o $ROUT_BIN/mux \
	     $PRIM_SRC/gate.v $PRIM_SRC/multigate.v $PRIM_SRC/gate8.v \
	     $ROUT_SRC/multiplexeur.v $ROUT_TEST/test_mux.v

    iverilog -o $ROUT_BIN/recurse_mux \
	     $PRIM_SRC/gate.v $PRIM_SRC/multigate.v $PRIM_SRC/gate8.v \
	     $ROUT_SRC/recurse_mux.v $ROUT_TEST/test_recurse_mux.v

    iverilog -o $ROUT_BIN/recurse_mux8 \
	     $PRIM_SRC/gate.v $PRIM_SRC/multigate.v $PRIM_SRC/gate8.v \
	     $PRIM_SRC/recursive_gate.v $ROUT_SRC/recurse_mux.v \
	     $ROUT_TEST/test_recurse_mux8.v

    iverilog -o $ROUT_BIN/recurse_demux \
	     $PRIM_SRC/gate.v $PRIM_SRC/multigate.v $PRIM_SRC/gate8.v \
	     $PRIM_SRC/recursive_gate.v $ROUT_SRC/recurse_demux.v \
	     $ROUT_TEST/test_recurse_demux.v

    iverilog -o $ROUT_BIN/recurse_demux8 \
	     $PRIM_SRC/gate.v $PRIM_SRC/multigate.v $PRIM_SRC/gate8.v \
	     $PRIM_SRC/recursive_gate.v $ROUT_SRC/recurse_demux.v \
	     $ROUT_TEST/test_recurse_demux8.v

    iverilog -o $ROUT_BIN/replicator \
	     $PRIM_SRC/gate.v $PRIM_SRC/recursive_gate.v $ROUT_SRC/replicator.v \
	     $ROUT_TEST/test_replicator.v

    iverilog -o $ROUT_BIN/fragmented_replicator \
	     $PRIM_SRC/gate.v $PRIM_SRC/recursive_gate.v $ROUT_SRC/replicator.v \
	     $ROUT_TEST/test_fragmented_replicator.v
}

test_routing()
{
    $ROUT_BIN/mux > $ROUT_DEBUG/mux
    $ROUT_BIN/mux > $ROUT_DEBUG/mux_1x8
    $ROUT_BIN/mux > $ROUT_DEBUG/mux_8bitx2

    $ROUT_BIN/recurse_mux    > $ROUT_DEBUG/recurse_mux
    $ROUT_BIN/recurse_mux8   > $ROUT_DEBUG/recurse_mux8
    $ROUT_BIN/recurse_demux  > $ROUT_DEBUG/recurse_demux
    $ROUT_BIN/recurse_demux8 > $ROUT_DEBUG/recurse_demux8

    $ROUT_BIN/replicator > $ROUT_DEBUG/replicator
    $ROUT_BIN/fragmented_replicator > $ROUT_DEBUG/fragmented_replicator
}

compil_memory()
{
    MEM_TEST="memory/test"

    iverilog -o $MEM_BIN/basculeD \
	     $PRIM_SRC/gate.v $PRIM_SRC/multigate.v $PRIM_SRC/gate8.v \
	     $PRIM_SRC/recursive_gate.v $MEM_SRC/basculeD.v $MEM_TEST/test_basculeD.v

    iverilog -o $MEM_BIN/Dflipflop \
	     $PRIM_SRC/gate.v $PRIM_SRC/multigate.v $PRIM_SRC/gate8.v \
	     $PRIM_SRC/recursive_gate.v $MEM_SRC/basculeD.v $MEM_TEST/test_Dflipflop.v

    iverilog -o $MEM_BIN/JKlatchUP \
	     $PRIM_SRC/gate.v $PRIM_SRC/multigate.v $PRIM_SRC/gate8.v \
	     $PRIM_SRC/recursive_gate.v $MEM_SRC/JKlatch.v  $MEM_TEST/test_JKlatchUP.v

    iverilog -o $MEM_BIN/regdec \
	     $PRIM_SRC/gate.v \
	     $PRIM_SRC/multigate.v \
	     $PRIM_SRC/gate8.v \
	     $PRIM_SRC/recursive_gate.v \
	     $MEM_SRC/regdec.v \
	     $MEM_TEST/test_regdec.v

    iverilog -o $MEM_BIN/recursive_Dlatch \
	     $PRIM_SRC/gate.v $PRIM_SRC/multigate.v $PRIM_SRC/gate8.v \
	     $PRIM_SRC/recursive_gate.v $MEM_SRC/basculeD.v \
	     $MEM_TEST/test_recursive_Dlatch.v

    iverilog -o $MEM_BIN/recursive_Dlatch256 \
	     $PRIM_SRC/gate.v $PRIM_SRC/multigate.v $PRIM_SRC/gate8.v \
	     $PRIM_SRC/recursive_gate.v $MEM_SRC/basculeD.v \
	     $MEM_TEST/test_recursive_Dlatch256.v

    iverilog -o $MEM_BIN/memory \
	     $PRIM_SRC/gate.v $PRIM_SRC/multigate.v $PRIM_SRC/gate8.v \
	     $PRIM_SRC/recursive_gate.v $MEM_SRC/basculeD.v \
	     $MEM_SRC/memory.v $MEM_TEST/test_memory.v\
	     $ROUT_SRC/replicator.v $ROUT_SRC/recurse_demux.v \
	     $ROUT_SRC/recurse_mux.v

    iverilog -o $MEM_BIN/blockreg \
	     $PRIM_SRC/gate.v $PRIM_SRC/multigate.v $PRIM_SRC/gate8.v \
	     $PRIM_SRC/recursive_gate.v $MEM_SRC/basculeD.v \
	     $ROUT_SRC/replicator.v $ROUT_SRC/recurse_demux.v \
	     $ROUT_SRC/recurse_mux.v $MEM_SRC/blockreg.v $MEM_TEST/test_blockreg.v

    iverilog -o $MEM_BIN/sequential_regdec_left \
	     $MEM_SRC/sequential_regdec.v $MEM_SRC/basculeD.v $ROUT_SRC/recurse_mux.v \
	     $PRIM_SRC/gate.v $MEM_TEST/test_sequential_regdec_left.v

    iverilog -o $MEM_BIN/sequential_regdec_right \
	     $MEM_SRC/sequential_regdec.v $MEM_SRC/basculeD.v $ROUT_SRC/recurse_mux.v \
	     $PRIM_SRC/gate.v $MEM_TEST/test_sequential_regdec_right.v
}

test_memory()
{
    $MEM_BIN/basculeD                > $MEM_DEBUG/basculeD
    $MEM_BIN/Dflipflop               > $MEM_DEBUG/Dflipflop
    $MEM_BIN/JKlatchUP               > $MEM_DEBUG/JKlatchUP
    $MEM_BIN/regdec                  > $MEM_DEBUG/regdec
    $MEM_BIN/recursive_Dlatch        > $MEM_DEBUG/recursive_Dlatch
    $MEM_BIN/recursive_Dlatch256     > $MEM_DEBUG/recursive_Dlatch256
    $MEM_BIN/memory                  > $MEM_DEBUG/memory
    $MEM_BIN/sequential_regdec_left  > $MEM_DEBUG/sequential_regdec_left
    $MEM_BIN/sequential_regdec_right > $MEM_DEBUG/sequential_regdec_right
    
}

compil_compteur()
{
    CPT_TEST="compteur/test"

    iverilog -o $CPT_BIN/bit_cpt3 \
	     $PRIM_SRC/gate.v $PRIM_SRC/multigate.v $PRIM_SRC/gate8.v \
	     $PRIM_SRC/recursive_gate.v $MEM_SRC/basculeD.v $CPT_SRC/bit_cpt3.v \
	     $CPT_TEST/test_bit_cpt3.v

    iverilog -o $CPT_BIN/cpt_bin \
	     $PRIM_SRC/gate.v $PRIM_SRC/multigate.v $PRIM_SRC/gate8.v \
	     $PRIM_SRC/recursive_gate.v \ $MEM_SRC/JKlatch.v  $CPT_SRC/cpt_bin.v \
	     $CPT_TEST/test_cpt_bin.v
}

test_compteur()
{
    $CPT_BIN/cpt_bin  > $CPT_DEBUG/cpt_bin
    $CPT_BIN/bit_cpt3 > $CPT_DEBUG/bit_cpt3
}

compil_alu_arithm()
{
    ALU_ARITHM_TEST="alu/arithm/test"

    iverilog -o $ALU_ARITHM_BIN/add \
	     $PRIM_SRC/gate.v $PRIM_SRC/multigate.v $PRIM_SRC/gate8.v \
	     $PRIM_SRC/recursive_gate.v $ALU_ARITHM_SRC/add.v \
	     $ALU_ARITHM_TEST/test_add.v

    iverilog -o $ALU_ARITHM_BIN/add8 \
	     $PRIM_SRC/gate.v $PRIM_SRC/multigate.v $PRIM_SRC/gate8.v \
	     $PRIM_SRC/recursive_gate.v $ALU_ARITHM_SRC/add.v $ALU_ARITHM_SRC/add8.v \
	     $ALU_ARITHM_TEST/test_add8.v

    iverilog -o $ALU_ARITHM_BIN/cmp \
	     $PRIM_SRC/gate.v $PRIM_SRC/multigate.v $PRIM_SRC/gate8.v \
	     $PRIM_SRC/recursive_gate.v $ALU_ARITHM_SRC/cmp.v \
	     $ALU_ARITHM_TEST/test_cmp.v

    iverilog -o $ALU_ARITHM_BIN/cmp8 \
	     $PRIM_SRC/gate.v $PRIM_SRC/multigate.v $PRIM_SRC/gate8.v \
	     $PRIM_SRC/recursive_gate.v $ALU_ARITHM_SRC/cmp.v \
	     $ALU_ARITHM_TEST/test_cmp8.v

    iverilog -o $ALU_ARITHM_BIN/divmod2 \
	     $PRIM_SRC/gate.v $PRIM_SRC/multigate.v $PRIM_SRC/gate8.v \
	     $PRIM_SRC/recursive_gate.v $ROUT_SRC/multiplexeur.v \
	     $MEM_SRC/basculeD.v $MEM_SRC/JKlatch.v  $MEM_SRC/regdec.v \
	     $ALU_ARITHM_SRC/divmod2.v $ALU_ARITHM_SRC/add.v $ALU_ARITHM_SRC/add8.v \
	     $CPT_SRC/bit_cpt3.v $ALU_ARITHM_TEST/test_divmod2.v

    iverilog -o $ALU_ARITHM_BIN/mult \
	     $PRIM_SRC/gate.v $PRIM_SRC/multigate.v $PRIM_SRC/gate8.v \
	     $PRIM_SRC/recursive_gate.v $ROUT_SRC/multiplexeur.v \
	     $MEM_SRC/basculeD.v $MEM_SRC/JKlatch.v  $MEM_SRC/regdec.v \
	     $ALU_ARITHM_SRC/divmod2.v $CPT_SRC/*.v $ROUT_SRC/demultiplexeur.v \
	     $ALU_ARITHM_SRC/mult.v $ALU_ARITHM_SRC/add.v $ALU_ARITHM_SRC/add8.v \
	     $ALU_ARITHM_TEST/test_mult.v

    iverilog -o $ALU_ARITHM_BIN/mult8 \
	     $PRIM_SRC/gate.v $PRIM_SRC/multigate.v $PRIM_SRC/gate8.v \
	     $PRIM_SRC/recursive_gate.v $ROUT_SRC/multiplexeur.v \
	     $MEM_SRC/basculeD.v $MEM_SRC/JKlatch.v  $MEM_SRC/regdec.v \
	     $ALU_ARITHM_SRC/divmod2.v $CPT_SRC/*.v $ROUT_SRC/demultiplexeur.v \
	     $ALU_ARITHM_SRC/mult.v $ALU_ARITHM_SRC/add.v $ALU_ARITHM_SRC/add8.v\
	     $ALU_ARITHM_TEST/test_mult8.v

    iverilog -o $ALU_ARITHM_BIN/multi_add \
	     $PRIM_SRC/gate.v $ALU_ARITHM_SRC/add.v $ALU_ARITHM_SRC/multi_add.v \
	     $ALU_ARITHM_TEST/test_multi_add.v
}

test_alu_arithm()
{
    $ALU_ARITHM_BIN/add     > $ALU_ARITHM_DEBUG/add
    $ALU_ARITHM_BIN/add8    > $ALU_ARITHM_DEBUG/add8
    $ALU_ARITHM_BIN/cmp     > $ALU_ARITHM_DEBUG/cmp
    $ALU_ARITHM_BIN/cmp8    > $ALU_ARITHM_DEBUG/cmp8
    $ALU_ARITHM_BIN/divmod2 > $ALU_ARITHM_DEBUG/divmod2
    $ALU_ARITHM_BIN/mult    > $ALU_ARITHM_DEBUG/mult
    $ALU_ARITHM_BIN/mult8   > $ALU_ARITHM_DEBUG/mult8
}

compil_alu_main()
{
    ALU_MAIN_TEST="alu/alu/test/"

    iverilog -o $ALU_MAIN_BIN/alu \
	     $PRIM_SRC/gate.v $PRIM_SRC/multigate.v $PRIM_SRC/gate8.v \
	     $PRIM_SRC/recursive_gate.v $ROUT_SRC/*.v \
	     $MEM_SRC/basculeD.v $MEM_SRC/JKlatch.v  $MEM_SRC/regdec.v \
	     $ALU_ARITHM_SRC/*.v $CPT_SRC/*.v \
	     $ALU_MAIN_SRC/alu.v $ALU_MAIN_TEST/test_alu.v
}

test_alu_main()
{
    $ALU_MAIN_BIN/alu > $ALU_MAIN_DEBUG/alu
}

compil_datapath()
{
    DATAPATH_TEST="datapath/test/test_datapath.v"
    DATAPATH_SRC="datapath/src/datapath.v"
    DATAPATH_BIN="build/datapath/bin"

    iverilog `find . -name *.v | grep src` datapath/test/test_datapath.v -o $DATAPATH_BIN/datapath
}

test_datapath()
{
    $DATAPATH_BIN/datapath > build/datapath/debug/datapath
}

generate_netlist()
{
    #    yosys -o $PRIM_BUILD/netlist/gate.blif -S $PRIM_SRC/gate.v > $PRIM_DEBUG/yosys_primitive_netlist_out
    yosys -o build/netlist/logilib.blif -S `find . -name *.v | grep src` > build/netlist/yosys_netlist_out
}

generate_schematic()
{
    echo "read_verilog memory/src/basculeD.v primitive/src/gate.v" >  build/generate_schematic.ys
    echo "hierarchy -check" >> build/generate_schematic.ys
    echo "proc; fsm;" >> build/generate_schematic.ys
    echo "show -format dot" >> build/generate_schematic.ys
#    echo "techmap;" >> generate_primitive_netlist_and_schematic.ys
#    echo "write_verilog gate.v;" >> generate_primitive_netlist_and_schematic.ys
    
    yosys -s build/generate_schematic.ys -l build/yosys_schematic_out -q
    dot -Tps ~/.yosys_show.dot -o build/schematic/schematic.ps
}

make_dir()
{
    mkdir -p build/netlist build/schematic
    mkdir -p $PRIM_BUILD/log  $PRIM_BUILD/signal $PRIM_DEBUG $PRIM_BIN 
    mkdir -p $ROUT_BUILD/log  $ROUT_BUILD/signal $ROUT_DEBUG $ROUT_BIN
    mkdir -p $MEM_BUILD/log   $MEM_BUILD/signal  $MEM_DEBUG  $MEM_BIN
    mkdir -p $CPT_BUILD/log   $CPT_BUILD/signal  $CPT_DEBUG  $CPT_BIN
    
    mkdir -p $ALU_ARITHM_BUILD/log $ALU_ARITHM_BUILD/signal $ALU_ARITHM_DEBUG $ALU_ARITHM_BIN
    mkdir -p $ALU_MAIN_BUILD/log   $ALU_MAIN_BUILD/signal   $ALU_MAIN_DEBUG   $ALU_MAIN_BIN

    mkdir -p build/datapath/bin build/datapath/signal build/datapath/debug build/datapath/log
}

compil()
{
    make_dir

    compil_primitive
    compil_routing
    compil_memory
    compil_compteur
    compil_alu_arithm
    compil_alu_main
#    compil_datapath

    test_primitive
    test_routing
    test_memory
    test_compteur
    test_alu_arithm
    test_alu_main
#    test_datapath

#    generate_netlist

#    generate_schematic
}

compil
