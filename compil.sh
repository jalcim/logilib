#!/bin/sh

PRIM_SRC="primitive/src"
ROUT_SRC="routing/src"
MEM_SRC="memory/src"
COMPT_SRC="compteur/src"
ALU_ARITHM_SRC="alu/arithm/src"

PRIM_BUILD="build/primitive"
ROUT_BUILD="build/routing"
MEM_BUILD="build/memory"
COMPT_BUILD="build/compteur"
ALU_ARITHM_BUILD="build/alu/arithm"

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
    $PRIM_BUILD/not  > build/primitive/debug/not
    $PRIM_BUILD/buf  > build/primitive/debug/buf
    $PRIM_BUILD/and  > build/primitive/debug/and
    $PRIM_BUILD/nand > build/primitive/debug/nand
    $PRIM_BUILD/or   > build/primitive/debug/or
    $PRIM_BUILD/nor  > build/primitive/debug/nor
    $PRIM_BUILD/xor  > build/primitive/debug/xor
    $PRIM_BUILD/xnor > build/primitive/debug/xnor

    $PRIM_BUILD/and8 > build/primitive/debug/and8
}

compil_routing()
{
    ROUT_TEST="routing/test"

    iverilog $PRIM_SRC/*.v $ROUT_SRC/multiplexeur.v $ROUT_TEST/test_mux_1x8.v -o $ROUT_BUILD/mux_1x8
    iverilog $PRIM_SRC/*.v $ROUT_SRC/multiplexeur.v $ROUT_TEST/test_mux_8bitx2.v -o $ROUT_BUILD/mux_8bitx2
    iverilog $PRIM_SRC/*.v $ROUT_SRC/multiplexeur.v $ROUT_TEST/test_mux.v -o $ROUT_BUILD/mux

    iverilog $PRIM_SRC/*.v $ROUT_SRC/recurse_mux.v $ROUT_TEST/test_recurse_mux.v -o $ROUT_BUILD/recurse_mux
    iverilog $PRIM_SRC/*.v $ROUT_SRC/recurse_mux.v $ROUT_TEST/test_recurse_mux8.v -o $ROUT_BUILD/recurse_mux8
}

test_routing()
{
    $ROUT_BUILD/mux > build/routing/debug/mux
    $ROUT_BUILD/mux > build/routing/debug/mux_1x8
    $ROUT_BUILD/mux > build/routing/debug/mux_8bitx2

    $ROUT_BUILD/recurse_mux > build/routing/debug/recurse_mux
    $ROUT_BUILD/recurse_mux8 > build/routing/debug/recurse_mux8
}

compil_memory()
{
    MEM_TEST="memory/test"

    iverilog $PRIM_SRC/*.v $MEM_SRC/basculeD.v $MEM_TEST/test_basculeD.v -o $MEM_BUILD/basculeD
    iverilog $PRIM_SRC/*.v $MEM_SRC/basculeD.v $MEM_TEST/test_Dflipflop.v -o $MEM_BUILD/Dflipflop
    iverilog $PRIM_SRC/*.v $MEM_SRC/JKlatch.v $MEM_TEST/test_JKlatchUP.v -o $MEM_BUILD/JKlatchUP
    iverilog $PRIM_SRC/*.v $MEM_SRC/regdec.v $MEM_TEST/test_regdec.v -o $MEM_BUILD/regdec
}

compil_compteur()
{
    COMPT_TEST="compteur/test"

   iverilog $PRIM_SRC/*.v $MEM_SRC/basculeD.v $COMPT_SRC/bit_cpt3.v $COMPT_TEST/test_bit_cpt3.v -o $COMPT_BUILD/bit_cpt3
   iverilog $PRIM_SRC/*.v $MEM_SRC/JKlatch.v $COMPT_SRC/cpt_bin.v $COMPT_TEST/test_cpt_bin.v -o $COMPT_BUILD/cpt_bin
}

test_compteur()
{
    $COMPT_BUILD/cpt_bin  > build/compteur/debug/cpt_bin
    $COMPT_BUILD/bit_cpt3 > build/compteur/debug/bit_cpt3
}

compil_alu()
{
    ALU_ARITHM_TEST="alu/arithm/test"

    iverilog $PRIM_SRC/*.v $ALU_ARITHM_SRC/add.v $ALU_ARITHM_TEST/test_add.v -o $ALU_ARITHM_BUILD/add
    iverilog $PRIM_SRC/*.v $ALU_ARITHM_SRC/add.v $ALU_ARITHM_TEST/test_add8.v -o $ALU_ARITHM_BUILD/add8
    iverilog $PRIM_SRC/*.v $ALU_ARITHM_SRC/cmp.v $ALU_ARITHM_TEST/test_cmp.v -o $ALU_ARITHM_BUILD/cmp
    iverilog $PRIM_SRC/*.v $ALU_ARITHM_SRC/cmp.v $ALU_ARITHM_TEST/test_cmp8.v -o $ALU_ARITHM_BUILD/cmp8
    iverilog $PRIM_SRC/*.v $ROUT_SRC/multiplexeur.v $MEM_SRC/*.v $ALU_ARITHM_SRC/divmod2.v \
	     $ALU_ARITHM_SRC/add.v $COMPT_SRC/bit_cpt3.v $ALU_ARITHM_TEST/test_divmod2.v -o $ALU_ARITHM_BUILD/divmod2

    iverilog $PRIM_SRC/*.v $ROUT_SRC/multiplexeur.v $MEM_SRC/*.v $ALU_ARITHM_SRC/divmod2.v $COMPT_SRC/*.v \
	     $ROUT_SRC/demultiplexeur.v $ALU_ARITHM_SRC/mult.v $ALU_ARITHM_SRC/add.v $ALU_ARITHM_TEST/test_mult.v -o $ALU_ARITHM_BUILD/mult

    iverilog $PRIM_SRC/*.v $ROUT_SRC/multiplexeur.v $MEM_SRC/*.v $ALU_ARITHM_SRC/divmod2.v $COMPT_SRC/*.v \
	     $ROUT_SRC/demultiplexeur.v $ALU_ARITHM_SRC/mult.v $ALU_ARITHM_SRC/add.v $ALU_ARITHM_TEST/test_mult8.v -o $ALU_ARITHM_BUILD/mult8
}

test_alu()
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
    mkdir -p build/primitive/log build/primitive/signal build/primitive/debug
    mkdir -p build/routing/log   build/routing/signal   build/routing/debug
    mkdir -p build/memory/log    build/memory/signal    build/memory/debug
    mkdir -p build/compteur/log  build/compteur/signal  build/compteur/debug
    
    mkdir -p build/alu/arithm/log       build/alu/arithm/signal       build/alu/arithm/debug
    mkdir -p build/alu/main/log       build/alu/main/signal       build/alu/main/debug
}

compil()
{
    make_dir

    compil_primitive
    compil_routing
    compil_memory
    compil_compteur
    compil_alu
    
    test_primitive
    test_routing
    test_compteur
    test_alu
}

compil
