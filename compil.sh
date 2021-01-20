#!/bin/sh

PRIM_SRC="primitive/src"
ROUT_SRC="routing/src"
MEM_SRC="memory/src"
COMPT_SRC="compteur/src"
ALU_SRC="alu/src"

compil_primitive()
{
    PRIM_TEST="primitive/test"
    PRIM_BUILD="build/primitive"

    iverilog $PRIM_TEST/test_and.v $PRIM_SRC/gate.v -o $PRIM_BUILD/and
    iverilog $PRIM_TEST/test_or.v $PRIM_SRC/gate.v -o $PRIM_BUILD/or
    iverilog $PRIM_TEST/test_xor.v $PRIM_SRC/gate.v -o $PRIM_BUILD/xor
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
    iverilog $PRIM_SRC/*.v $MEM_SRC/*.v $MEM_TEST/test_JKlatchUP.v -o $MEM_BUILD/JKlatchUP
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

compil()
{
    mkdir -p build/primitive build/routing build/memory build/compteur build/alu
    compil_primitive
    compil_routing
    compil_memory
    compil_compteur
    compil_alu
}

compil
