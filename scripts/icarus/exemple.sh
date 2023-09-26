mkdir -p bin/exemple

iverilog -pRECURSIVE_MOD_LIMIT=100 -o bin/exemple/test_block_reg exemple/block_reg/test_block_reg.v
iverilog -pRECURSIVE_MOD_LIMIT=100 -o bin/exemple/test_block_mem exemple/block_mem/test_block_mem.v
iverilog -pRECURSIVE_MOD_LIMIT=100 -o bin/exemple/test_alu       exemple/alu/test_alu.v
