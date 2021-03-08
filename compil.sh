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

compil_primitive()
{
    PRIM_TEST="primitive/test"

    iverilog $PRIM_TEST/test_not.v $PRIM_SRC/gate.v -o $PRIM_BUILD/not
    iverilog $PRIM_TEST/test_buf.v $PRIM_SRC/gate.v -o $PRIM_BUILD/buf
    iverilog $PRIM_TEST/test_and.v $PRIM_SRC/gate.v -o $PRIM_BUILD/and
    iverilog $PRIM_TEST/test_nand.v $PRIM_SRC/gate.v -o $PRIM_BUILD/nand
    iverilog $PRIM_TEST/test_or.v $PRIM_SRC/gate.v -o $PRIM_BUILD/or
    iverilog $PRIM_TEST/test_nor.v $PRIM_SRC/gate.v -o $PRIM_BUILD/nor
    iverilog $PRIM_TEST/test_xor.v $PRIM_SRC/gate.v -o $PRIM_BUILD/xor
    iverilog $PRIM_TEST/test_xnor.v $PRIM_SRC/gate.v -o $PRIM_BUILD/xnor

    iverilog $PRIM_TEST/test_and8.v $PRIM_SRC/gate8.v $PRIM_SRC/gate.v -o $PRIM_BUILD/and8
}

test_primitive()
{
    $PRIM_BUILD/not  > $PRIM_DEBUG/not
    $PRIM_BUILD/buf  > $PRIM_DEBUG/buf
    $PRIM_BUILD/and  > $PRIM_DEBUG/and
    $PRIM_BUILD/nand > $PRIM_DEBUG/nand
    $PRIM_BUILD/or   > $PRIM_DEBUG/or
    $PRIM_BUILD/nor  > $PRIM_DEBUG/nor
    $PRIM_BUILD/xor  > $PRIM_DEBUG/xor
    $PRIM_BUILD/xnor > $PRIM_DEBUG/xnor

    $PRIM_BUILD/and8 > $PRIM_DEBUG/and8
}

compil_routing()
{
    ROUT_TEST="routing/test"

    iverilog $PRIM_SRC/*.v $ROUT_SRC/multiplexeur.v $ROUT_TEST/test_mux_1x8.v -o $ROUT_BUILD/mux_1x8
    iverilog $PRIM_SRC/*.v $ROUT_SRC/multiplexeur.v $ROUT_TEST/test_mux_8bitx2.v -o $ROUT_BUILD/mux_8bitx2
    iverilog $PRIM_SRC/*.v $ROUT_SRC/multiplexeur.v $ROUT_TEST/test_mux.v -o $ROUT_BUILD/mux

    iverilog $PRIM_SRC/*.v $ROUT_SRC/recurse_mux.v $ROUT_TEST/test_recurse_mux.v -o $ROUT_BUILD/recurse_mux
    iverilog $PRIM_SRC/*.v $ROUT_SRC/recurse_mux.v $ROUT_TEST/test_recurse_mux8.v -o $ROUT_BUILD/recurse_mux8
    iverilog $PRIM_SRC/*.v $ROUT_SRC/recurse_demux.v $ROUT_TEST/test_recurse_demux.v -o $ROUT_BUILD/recurse_demux
}

test_routing()
{
    $ROUT_BUILD/mux > $ROUT_DEBUG/mux
    $ROUT_BUILD/mux > $ROUT_DEBUG/mux_1x8
    $ROUT_BUILD/mux > $ROUT_DEBUG/mux_8bitx2

    $ROUT_BUILD/recurse_mux  > $ROUT_DEBUG/recurse_mux
    $ROUT_BUILD/recurse_mux8 > $ROUT_DEBUG/recurse_mux8
    $ROUT_BUILD/recurse_demux  > $ROUT_DEBUG/recurse_demux
}

compil_memory()
{
    MEM_TEST="memory/test"

    iverilog $PRIM_SRC/*.v $MEM_SRC/basculeD.v $MEM_TEST/test_basculeD.v  -o $MEM_BUILD/basculeD
    iverilog $PRIM_SRC/*.v $MEM_SRC/basculeD.v $MEM_TEST/test_Dflipflop.v -o $MEM_BUILD/Dflipflop
    iverilog $PRIM_SRC/*.v $MEM_SRC/JKlatch.v  $MEM_TEST/test_JKlatchUP.v -o $MEM_BUILD/JKlatchUP
    iverilog $PRIM_SRC/*.v $MEM_SRC/regdec.v   $MEM_TEST/test_regdec.v    -o $MEM_BUILD/regdec
}

compil_compteur()
{
    CPT_TEST="compteur/test"

   iverilog $PRIM_SRC/*.v $MEM_SRC/basculeD.v $CPT_SRC/bit_cpt3.v $CPT_TEST/test_bit_cpt3.v -o $CPT_BUILD/bit_cpt3
   iverilog $PRIM_SRC/*.v $MEM_SRC/JKlatch.v  $CPT_SRC/cpt_bin.v  $CPT_TEST/test_cpt_bin.v -o  $CPT_BUILD/cpt_bin
}

test_compteur()
{
    $CPT_BUILD/cpt_bin  > $CPT_DEBUG/cpt_bin
    $CPT_BUILD/bit_cpt3 > $CPT_DEBUG/bit_cpt3
}

compil_alu_arithm()
{
    ALU_ARITHM_TEST="alu/arithm/test"

    iverilog $PRIM_SRC/*.v $ALU_ARITHM_SRC/add.v $ALU_ARITHM_TEST/test_add.v -o $ALU_ARITHM_BUILD/add
    iverilog $PRIM_SRC/*.v $ALU_ARITHM_SRC/add.v $ALU_ARITHM_TEST/test_add8.v -o $ALU_ARITHM_BUILD/add8
    iverilog $PRIM_SRC/*.v $ALU_ARITHM_SRC/cmp.v $ALU_ARITHM_TEST/test_cmp.v -o $ALU_ARITHM_BUILD/cmp
    iverilog $PRIM_SRC/*.v $ALU_ARITHM_SRC/cmp.v $ALU_ARITHM_TEST/test_cmp8.v -o $ALU_ARITHM_BUILD/cmp8
    iverilog $PRIM_SRC/*.v $ROUT_SRC/multiplexeur.v $MEM_SRC/*.v $ALU_ARITHM_SRC/divmod2.v \
	     $ALU_ARITHM_SRC/add.v $CPT_SRC/bit_cpt3.v $ALU_ARITHM_TEST/test_divmod2.v -o $ALU_ARITHM_BUILD/divmod2

    iverilog $PRIM_SRC/*.v $ROUT_SRC/multiplexeur.v $MEM_SRC/*.v $ALU_ARITHM_SRC/divmod2.v $CPT_SRC/*.v \
	     $ROUT_SRC/demultiplexeur.v $ALU_ARITHM_SRC/mult.v $ALU_ARITHM_SRC/add.v $ALU_ARITHM_TEST/test_mult.v -o $ALU_ARITHM_BUILD/mult

    iverilog $PRIM_SRC/*.v $ROUT_SRC/multiplexeur.v $MEM_SRC/*.v $ALU_ARITHM_SRC/divmod2.v $CPT_SRC/*.v \
	     $ROUT_SRC/demultiplexeur.v $ALU_ARITHM_SRC/mult.v $ALU_ARITHM_SRC/add.v $ALU_ARITHM_TEST/test_mult8.v -o $ALU_ARITHM_BUILD/mult8
}

test_alu_arithm()
{
    $ALU_ARITHM_BUILD/add     > $ALU_ARITHM_BUILD/debug/add
    $ALU_ARITHM_BUILD/add8    > $ALU_ARITHM_BUILD/debug/add8
    $ALU_ARITHM_BUILD/cmp     > $ALU_ARITHM_BUILD/debug/cmp
    $ALU_ARITHM_BUILD/cmp8    > $ALU_ARITHM_BUILD/debug/cmp8
    $ALU_ARITHM_BUILD/divmod2 > $ALU_ARITHM_BUILD/debug/divmod2
    $ALU_ARITHM_BUILD/mult    > $ALU_ARITHM_BUILD/debug/mult
    $ALU_ARITHM_BUILD/mult8   > $ALU_ARITHM_BUILD/debug/mult8
}

make_dir()
{
    mkdir -p $PRIM_BUILD/log  $PRIM_BUILD/signal $PRIM_DEBUG $PRIM_BUILD/bin
    mkdir -p $ROUT_BUILD/log  $ROUT_BUILD/signal $ROUT_DEBUG $ROUT_BUILD/bin
    mkdir -p $MEM_BUILD/log   $MEM_BUILD/signal  $MEM_DEBUG  $MEM_BUILD/bin
    mkdir -p $CPT_BUILD/log   $CPT_BUILD/signal  $CPT_DEBUG  $CPT_BUILD/bin
    
    mkdir -p $ALU_ARITHM_BUILD/log $ALU_ARITHM_BUILD/signal $ALU_ARITHM_BUILD/debug $ALU_ARITHM_BUILD/bin
    mkdir -p $ALU_MAIN_BUILD/log   $ALU_MAIN_BUILD/signal   $ALU_MAIN_BUILD/debug $ALU_MAIN_BUILD/bin
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
