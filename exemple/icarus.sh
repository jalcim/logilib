#!/bin/bash

SRC_DEC=(
    "decodeur/decodeur.v"
    "decodeur/spliter/imm/I_imm_decoder.v"
    "decodeur/spliter/imm/J_imm_decoder.v"
    "decodeur/spliter/imm/B_imm_decoder.v"
    "decodeur/spliter/imm/S_imm_decoder.v"
    "decodeur/spliter/imm/U_imm_decoder.v"
    "decodeur/spliter/spliter.v"
    "decodeur/opcode/opcode.v"
    "decodeur/test_decodeur.v"
)

iverilog $SRC_DEC -o test_decodeur

