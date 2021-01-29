#!/bin/sh

PRIM_SRC="primitive/src"
ROUT_SRC="routing/src"
MEM_SRC="memory/src"
COMPT_SRC="compteur/src"
ALU_SRC="alu/src"

PRIM_BUILD="build/primitive"

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
}

test_primitive()
{
    $PRIM_BUILD/not
    $PRIM_BUILD/buf
    $PRIM_BUILD/and
    $PRIM_BUILD/nand
    $PRIM_BUILD/or
    $PRIM_BUILD/nor
    $PRIM_BUILD/xor
    $PRIM_BUILD/xnor
}

compil_routing()
{
    ROUT_TEST="routing/test"
    ROUT_BUILD="build/routing"

    iverilog $PRIM_SRC/*.v $ROUT_SRC/multiplexeur.v $ROUT_TEST/test_mux_1x8.v -o $ROUT_BUILD/mux_1x8
    iverilog $PRIM_SRC/*.v $ROUT_SRC/multiplexeur.v $ROUT_TEST/test_mux_8bitx2.v -o $ROUT_BUILD/mux_8bitx2
    iverilog $PRIM_SRC/*.v $ROUT_SRC/multiplexeur.v $ROUT_TEST/test_mux.v -o $ROUT_BUILD/mux
}

compil_memory()
{
    MEM_TEST="memory/test"
    MEM_BUILD="build/memory"

    iverilog $PRIM_SRC/*.v $MEM_SRC/basculeD.v $MEM_TEST/test_basculeD.v -o $MEM_BUILD/basculeD
    iverilog $PRIM_SRC/*.v $MEM_SRC/basculeD.v $MEM_TEST/test_Dflipflop.v -o $MEM_BUILD/Dflipflop
    iverilog $PRIM_SRC/*.v $MEM_SRC/JKlatch.v $MEM_TEST/test_JKlatchUP.v -o $MEM_BUILD/JKlatchUP
    iverilog $PRIM_SRC/*.v $MEM_SRC/regdec.v $MEM_TEST/test_regdec.v -o $MEM_BUILD/regdec
}

compil_compteur()
{
    COMPT_TEST="compteur/test"
    COMPT_BUILD="build/compteur"

   iverilog $PRIM_SRC/*.v $MEM_SRC/basculeD.v $COMPT_SRC/bit_cpt3.v $COMPT_TEST/test_bit_cpt3.v -o $COMPT_BUILD/bit_cpt3
   iverilog $PRIM_SRC/*.v $MEM_SRC/JKlatch.v $COMPT_SRC/cpt_bin.v $COMPT_TEST/test_cpt_bin.v -o $COMPT_BUILD/cpt_bin
}

compil_alu()
{
    ALU_TEST="alu/test"
    ALU_BUILD="build/alu"
    
    iverilog $PRIM_SRC/*.v $ALU_SRC/add.v $ALU_TEST/test_add.v -o $ALU_BUILD/add
    iverilog $PRIM_SRC/*.v $ALU_SRC/add.v $ALU_TEST/test_add8.v -o $ALU_BUILD/add8
    iverilog $PRIM_SRC/*.v $ALU_SRC/cmp.v $ALU_TEST/test_cmp.v -o $ALU_BUILD/cmp
    iverilog $PRIM_SRC/*.v $ALU_SRC/cmp.v $ALU_TEST/test_cmp8.v -o $ALU_BUILD/cmp8
    iverilog $PRIM_SRC/*.v $ROUT_SRC/multiplexeur.v $MEM_SRC/*.v $ALU_SRC/divmod2.v \
	     $ALU_SRC/add.v $COMPT_SRC/bit_cpt3.v $ALU_TEST/test_divmod2.v -o $ALU_BUILD/divmod2

    iverilog $PRIM_SRC/*.v $ROUT_SRC/multiplexeur.v $MEM_SRC/*.v $ALU_SRC/divmod2.v $COMPT_SRC/*.v \
	     $ROUT_SRC/demultiplexeur.v $ALU_SRC/mult.v $ALU_SRC/add.v $ALU_TEST/test_mult.v -o $ALU_BUILD/mult

    iverilog $PRIM_SRC/*.v $ROUT_SRC/multiplexeur.v $MEM_SRC/*.v $ALU_SRC/divmod2.v $COMPT_SRC/*.v \
	     $ROUT_SRC/demultiplexeur.v $ALU_SRC/mult.v $ALU_SRC/add.v $ALU_TEST/test_mult8.v -o $ALU_BUILD/mult8
}

make_dir()
{
    mkdir -p build/primitive/log build/primitive/signal
    mkdir -p build/routing/log   build/routing/signal
    mkdir -p build/memory/log    build/memory/signal
    mkdir -p build/compteur/log  build/compteur/signal
    mkdir -p build/alu/log       build/alu/signal
}

compil()
{
    make_dir
    
    compil_primitive
    test_primitive

    compil_routing
    compil_memory
    compil_compteur
    compil_alu
}

compil
