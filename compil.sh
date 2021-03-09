#!/bin/sh

PRIM_SRC="primitive/src"
ROUT_SRC="routing/src"
MEM_SRC="memory/src"
CPT_SRC="compteur/src"
ALU_ARITHM_SRC="alu/arithm/src"
ALU_MAIN_SRC="alu/main/src"

PRIM_BUILD="build/primitive"
ROUT_BUILD="build/routing"
MEM_BUILD="build/memory"
CPT_BUILD="build/compteur"
ALU_ARITHM_BUILD="build/alu/arithm"
ALU_MAIN_BUILD="build/alu/main"

PRIM_DEBUG="build/primitive/debug"
ROUT_DEBUG="build/routing/debug"
MEM_DEBUG="build/memory/debug"
CPT_DEBUG="build/compteur/debug"
ALU_ARITHM_DEBUG="build/alu/arithm/debug"
ALU_MAIN_DEBUG="build/alu/main/debug"

PRIM_BIN="build/primitive/bin"
ROUT_BIN="build/routing/bin"
MEM_BIN="build/memory/bin"
CPT_BIN="build/compteur/bin"
ALU_ARITHM_BIN="build/alu/arithm/bin"
ALU_MAIN_BIN="build/alu/main/bin"


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
}

compil_routing()
{
    ROUT_TEST="routing/test"

    iverilog $PRIM_SRC/*.v $ROUT_SRC/multiplexeur.v $ROUT_TEST/test_mux_1x8.v -o $ROUT_BIN/mux_1x8
    iverilog $PRIM_SRC/*.v $ROUT_SRC/multiplexeur.v $ROUT_TEST/test_mux_8bitx2.v -o $ROUT_BIN/mux_8bitx2
    iverilog $PRIM_SRC/*.v $ROUT_SRC/multiplexeur.v $ROUT_TEST/test_mux.v -o $ROUT_BIN/mux

    iverilog $PRIM_SRC/*.v $ROUT_SRC/recurse_mux.v $ROUT_TEST/test_recurse_mux.v -o $ROUT_BIN/recurse_mux
    iverilog $PRIM_SRC/*.v $ROUT_SRC/recurse_mux.v $ROUT_TEST/test_recurse_mux8.v -o $ROUT_BIN/recurse_mux8
    iverilog $PRIM_SRC/*.v $ROUT_SRC/recurse_demux.v $ROUT_TEST/test_recurse_demux.v -o $ROUT_BIN/recurse_demux
}

test_routing()
{
    $ROUT_BIN/mux > $ROUT_DEBUG/mux
    $ROUT_BIN/mux > $ROUT_DEBUG/mux_1x8
    $ROUT_BIN/mux > $ROUT_DEBUG/mux_8bitx2

    $ROUT_BIN/recurse_mux   > $ROUT_DEBUG/recurse_mux
    $ROUT_BIN/recurse_mux8  > $ROUT_DEBUG/recurse_mux8
    $ROUT_BIN/recurse_demux > $ROUT_DEBUG/recurse_demux
}

compil_memory()
{
    MEM_TEST="memory/test"

    iverilog $PRIM_SRC/*.v $MEM_SRC/basculeD.v $MEM_TEST/test_basculeD.v  -o $MEM_BIN/basculeD
    iverilog $PRIM_SRC/*.v $MEM_SRC/basculeD.v $MEM_TEST/test_Dflipflop.v -o $MEM_BIN/Dflipflop
    iverilog $PRIM_SRC/*.v $MEM_SRC/JKlatch.v  $MEM_TEST/test_JKlatchUP.v -o $MEM_BIN/JKlatchUP
    iverilog $PRIM_SRC/*.v $MEM_SRC/regdec.v   $MEM_TEST/test_regdec.v    -o $MEM_BIN/regdec
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
    
    test_primitive
    test_routing
    test_compteur
    test_alu_arithm
}

compil
