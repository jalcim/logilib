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

    iverilog $PRIM_TEST/test_not.v $PRIM_SRC/gate.v -o $PRIM_BIN/not
    iverilog $PRIM_TEST/test_buf.v $PRIM_SRC/gate.v -o $PRIM_BIN/buf
    iverilog $PRIM_TEST/test_and.v $PRIM_SRC/gate.v -o $PRIM_BIN/and
    iverilog $PRIM_TEST/test_nand.v $PRIM_SRC/gate.v -o $PRIM_BIN/nand
    iverilog $PRIM_TEST/test_or.v $PRIM_SRC/gate.v -o $PRIM_BIN/or
    iverilog $PRIM_TEST/test_nor.v $PRIM_SRC/gate.v -o $PRIM_BIN/nor
    iverilog $PRIM_TEST/test_xor.v $PRIM_SRC/gate.v -o $PRIM_BIN/xor
    iverilog $PRIM_TEST/test_xnor.v $PRIM_SRC/gate.v -o $PRIM_BIN/xnor

    iverilog $PRIM_TEST/test_and8.v $PRIM_SRC/gate8.v $PRIM_SRC/gate.v -o $PRIM_BIN/and8

    iverilog $PRIM_SRC/recursive_gate.v $PRIM_TEST/test_recursive_buf.v  $PRIM_SRC/gate.v -o $PRIM_BIN/recursive_buf
    iverilog $PRIM_SRC/recursive_gate.v $PRIM_TEST/test_recursive_not.v  $PRIM_SRC/gate.v -o $PRIM_BIN/recursive_not
    iverilog $PRIM_SRC/recursive_gate.v $PRIM_TEST/test_recursive_and.v  $PRIM_SRC/gate.v -o $PRIM_BIN/recursive_and
    iverilog $PRIM_SRC/recursive_gate.v $PRIM_TEST/test_recursive_or.v   $PRIM_SRC/gate.v -o $PRIM_BIN/recursive_or
    iverilog $PRIM_SRC/recursive_gate.v $PRIM_TEST/test_recursive_xor.v  $PRIM_SRC/gate.v -o $PRIM_BIN/recursive_xor
    iverilog $PRIM_SRC/recursive_gate.v $PRIM_TEST/test_recursive_xnor.v $PRIM_SRC/gate.v -o $PRIM_BIN/recursive_xnor
    iverilog $PRIM_SRC/recursive_gate.v $PRIM_TEST/test_recursive_nand.v $PRIM_SRC/gate.v -o $PRIM_BIN/recursive_nand
    iverilog $PRIM_SRC/recursive_gate.v $PRIM_TEST/test_recursive_nor.v  $PRIM_SRC/gate.v -o $PRIM_BIN/recursive_nor
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

    iverilog $PRIM_SRC/*.v $ROUT_SRC/multiplexeur.v $ROUT_TEST/test_mux_1x8.v         -o $ROUT_BIN/mux_1x8
    iverilog $PRIM_SRC/*.v $ROUT_SRC/multiplexeur.v $ROUT_TEST/test_mux_8bitx2.v      -o $ROUT_BIN/mux_8bitx2
    iverilog $PRIM_SRC/*.v $ROUT_SRC/multiplexeur.v $ROUT_TEST/test_mux.v             -o $ROUT_BIN/mux

    iverilog $PRIM_SRC/*.v $ROUT_SRC/recurse_mux.v $ROUT_TEST/test_recurse_mux.v      -o $ROUT_BIN/recurse_mux
    iverilog $PRIM_SRC/*.v $ROUT_SRC/recurse_mux.v $ROUT_TEST/test_recurse_mux8.v     -o $ROUT_BIN/recurse_mux8
    iverilog $PRIM_SRC/*.v $ROUT_SRC/recurse_demux.v $ROUT_TEST/test_recurse_demux.v  -o $ROUT_BIN/recurse_demux
    iverilog $PRIM_SRC/*.v $ROUT_SRC/recurse_demux.v $ROUT_TEST/test_recurse_demux8.v -o $ROUT_BIN/recurse_demux8

    iverilog $PRIM_SRC/gate.v $PRIM_SRC/recursive_gate.v $ROUT_SRC/replicator.v \
	     $ROUT_TEST/test_replicator.v                                             -o $ROUT_BIN/replicator
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
}

compil_memory()
{
    MEM_TEST="memory/test"

    iverilog $PRIM_SRC/*.v $MEM_SRC/basculeD.v $MEM_TEST/test_basculeD.v  -o $MEM_BIN/basculeD
    iverilog $PRIM_SRC/*.v $MEM_SRC/basculeD.v $MEM_TEST/test_Dflipflop.v -o $MEM_BIN/Dflipflop
    iverilog $PRIM_SRC/*.v $MEM_SRC/JKlatch.v  $MEM_TEST/test_JKlatchUP.v -o $MEM_BIN/JKlatchUP
    iverilog $PRIM_SRC/*.v $MEM_SRC/regdec.v   $MEM_TEST/test_regdec.v    -o $MEM_BIN/regdec
    iverilog $PRIM_SRC/*.v $MEM_SRC/basculeD.v   $MEM_TEST/test_recursive_Dlatch.v    -o $MEM_BIN/recursive_Dlatch
    iverilog $PRIM_SRC/*.v $MEM_SRC/basculeD.v   $MEM_TEST/test_recursive_Dlatch256.v    -o $MEM_BIN/recursive_Dlatch256
}

test_memory()
{
    $MEM_BIN/basculeD     > $MEM_DEBUG/basculeD
    $MEM_BIN/Dflipflop    > $MEM_DEBUG/Dflipflop
    $MEM_BIN/JKlatchUP    > $MEM_DEBUG/JKlatchUP
    $MEM_BIN/regdec       > $MEM_DEBUG/regdec
    $MEM_BIN/recursive_Dlatch > $MEM_DEBUG/recursive_Dlatch
    $MEM_BIN/recursive_Dlatch256 > $MEM_DEBUG/recursive_Dlatch256
}

compil_compteur()
{
    CPT_TEST="compteur/test"

   iverilog $PRIM_SRC/*.v $MEM_SRC/basculeD.v $CPT_SRC/bit_cpt3.v $CPT_TEST/test_bit_cpt3.v -o $CPT_BIN/bit_cpt3
   iverilog $PRIM_SRC/*.v $MEM_SRC/JKlatch.v  $CPT_SRC/cpt_bin.v  $CPT_TEST/test_cpt_bin.v -o  $CPT_BIN/cpt_bin
}

test_compteur()
{
    $CPT_BIN/cpt_bin  > $CPT_DEBUG/cpt_bin
    $CPT_BIN/bit_cpt3 > $CPT_DEBUG/bit_cpt3
}

compil_alu_arithm()
{
    ALU_ARITHM_TEST="alu/arithm/test"

    iverilog $PRIM_SRC/*.v $ALU_ARITHM_SRC/add.v $ALU_ARITHM_TEST/test_add.v  -o $ALU_ARITHM_BIN/add
    iverilog $PRIM_SRC/*.v $ALU_ARITHM_SRC/add.v $ALU_ARITHM_TEST/test_add8.v -o $ALU_ARITHM_BIN/add8
    iverilog $PRIM_SRC/*.v $ALU_ARITHM_SRC/cmp.v $ALU_ARITHM_TEST/test_cmp.v  -o $ALU_ARITHM_BIN/cmp
    iverilog $PRIM_SRC/*.v $ALU_ARITHM_SRC/cmp.v $ALU_ARITHM_TEST/test_cmp8.v -o $ALU_ARITHM_BIN/cmp8
    iverilog $PRIM_SRC/*.v $ROUT_SRC/multiplexeur.v $MEM_SRC/*.v \
	     $ALU_ARITHM_SRC/divmod2.v $ALU_ARITHM_SRC/add.v \
	     $CPT_SRC/bit_cpt3.v $ALU_ARITHM_TEST/test_divmod2.v              -o $ALU_ARITHM_BIN/divmod2

    iverilog $PRIM_SRC/*.v $ROUT_SRC/multiplexeur.v $MEM_SRC/*.v \
	     $ALU_ARITHM_SRC/divmod2.v $CPT_SRC/*.v $ROUT_SRC/demultiplexeur.v \
	     $ALU_ARITHM_SRC/mult.v $ALU_ARITHM_SRC/add.v \
	     $ALU_ARITHM_TEST/test_mult.v                                     -o $ALU_ARITHM_BIN/mult

    iverilog $PRIM_SRC/*.v $ROUT_SRC/multiplexeur.v $MEM_SRC/*.v \
	     $ALU_ARITHM_SRC/divmod2.v $CPT_SRC/*.v $ROUT_SRC/demultiplexeur.v \
	     $ALU_ARITHM_SRC/mult.v $ALU_ARITHM_SRC/add.v \
	     $ALU_ARITHM_TEST/test_mult8.v                                    -o $ALU_ARITHM_BIN/mult8
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

    iverilog $PRIM_SRC/*.v $ROUT_SRC/*.v $MEM_SRC/*.v \
	     $ALU_ARITHM_SRC/*.v $CPT_SRC/*.v \
	     $ALU_MAIN_SRC/alu.v $ALU_MAIN_TEST/test_alu.v -o $ALU_MAIN_BIN/alu
}

test_alu_main()
{
    $ALU_MAIN_BIN/alu > $ALU_MAIN_DEBUG/alu
}

make_dir()
{
    mkdir -p $PRIM_BUILD/log  $PRIM_BUILD/signal $PRIM_DEBUG $PRIM_BIN
    mkdir -p $ROUT_BUILD/log  $ROUT_BUILD/signal $ROUT_DEBUG $ROUT_BIN
    mkdir -p $MEM_BUILD/log   $MEM_BUILD/signal  $MEM_DEBUG  $MEM_BIN
    mkdir -p $CPT_BUILD/log   $CPT_BUILD/signal  $CPT_DEBUG  $CPT_BIN
    
    mkdir -p $ALU_ARITHM_BUILD/log $ALU_ARITHM_BUILD/signal $ALU_ARITHM_DEBUG $ALU_ARITHM_BIN
    mkdir -p $ALU_MAIN_BUILD/log   $ALU_MAIN_BUILD/signal   $ALU_MAIN_DEBUG   $ALU_MAIN_BIN
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
    
    test_primitive
    test_routing
    test_memory
    test_compteur
    test_alu_arithm
    test_alu_main
}

compil
