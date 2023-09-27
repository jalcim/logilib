mkdir -p bin/exemple

iverilog -o bin/exemple/test_block_reg exemple/block_reg/test_block_reg.v -pRECURSIVE_MOD_LIMIT=100
iverilog -o bin/exemple/test_block_mem exemple/block_mem/test_block_mem.v -pRECURSIVE_MOD_LIMIT=100
iverilog -o bin/exemple/test_alu       exemple/alu/test_alu.v             -pRECURSIVE_MOD_LIMIT=100
