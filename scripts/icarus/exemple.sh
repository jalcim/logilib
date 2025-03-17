#!/bin/bash

rm -rf bin/exemple
mkdir -p bin/exemple

echo "test_bru"
iverilog -pRECURSIVE_MOD_LIMIT=100 -o bin/exemple/test_bru       exemple/alu/bru/test_bru.v
echo "test_alu"
iverilog -pRECURSIVE_MOD_LIMIT=100 -o bin/exemple/test_alu       exemple/alu/test_alu.v

echo "test_block_reg"
iverilog -pRECURSIVE_MOD_LIMIT=100 -o bin/exemple/test_block_reg exemple/block_reg/test_block_reg.v

echo "test_decodeur"
iverilog -pRECURSIVE_MOD_LIMIT=100 -o bin/exemple/test_decodeur  exemple/decodeur/test_decodeur.v

echo "test_block_mem"
iverilog -pRECURSIVE_MOD_LIMIT=100 -o bin/exemple/test_block_mem exemple/lsu/block_mem/test_block_mem.v
echo "test_lsu"
iverilog -pRECURSIVE_MOD_LIMIT=10000 -o bin/exemple/test_lsu       exemple/lsu/test_lsu.v
echo "test_mux_load"
iverilog -pRECURSIVE_MOD_LIMIT=100 -o bin/exemple/test_mux_load  exemple/lsu/test_mux_load.v
echo "test_mux_store"
iverilog -pRECURSIVE_MOD_LIMIT=100 -o bin/exemple/test_mux_store exemple/lsu/test_mux_store.v

echo "test_pc"
iverilog -pRECURSIVE_MOD_LIMIT=100 -o bin/exemple/test_pc exemple/pc/test_pc.v

echo "test_rom"
iverilog -pRECURSIVE_MOD_LIMIT=100 -o bin/exemple/test_rom exemple/rom/test_rom.v

echo "test_write_back"
iverilog -pRECURSIVE_MOD_LIMIT=100 -o bin/exemple/test_write_back exemple/write_back/test_write_back.v

echo "test_lui"
iverilog -pRECURSIVE_MOD_LIMIT=100 -o bin/exemple/test_lui exemple/auipc_lui/lui/test_lui.v

echo "test_auipc"
iverilog -pRECURSIVE_MOD_LIMIT=100 -o bin/exemple/test_auipc exemple/auipc_lui/auipc/test_auipc.v

echo "test_auipc_lui"
iverilog -pRECURSIVE_MOD_LIMIT=100 -o bin/exemple/test_auipc_lui exemple/auipc_lui/test_auipc_lui.v

echo "test_jal"
iverilog -pRECURSIVE_MOD_LIMIT=100 -o bin/exemple/test_jal exemple/jal_jalr/jal/test_jal.v

echo "test_jalr"
iverilog -pRECURSIVE_MOD_LIMIT=100 -o bin/exemple/test_jalr exemple/jal_jalr/jalr/test_jalr.v

echo "test_jal_jalr"
iverilog -pRECURSIVE_MOD_LIMIT=100 -o bin/exemple/test_jal_jalr exemple/jal_jalr/test_jal_jalr.v

echo "test_datapath"
iverilog -pRECURSIVE_MOD_LIMIT=10000 -o bin/exemple/test_datapath exemple/test_datapath.v
