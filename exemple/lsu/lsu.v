`include "exemple/lsu/block_mem/block_mem.v"
`include "exemple/lsu/mux_load.v"
`include "exemple/lsu/mux_store.v"

module lsu (input [31:0] rs1,
	    input [31:0] rs2,
	    input [31:0] imm_S,
	    input [2:0] funct3,
	    input signal_store,
	    input clk,

	    output [31:0] data);

   parameter		  SIZE_ADDR_MEM = 32;
   parameter		  SIZE_MEM = 32;

   wire [SIZE_MEM-1:0]		  b_out;
   assign b_out = signal_store ? imm_S : rs2;

   ////////////////////////////////////////////////////////////

   wire [SIZE_MEM-1:0]		  add_out;
   assign add_out = rs1 + b_out;

   ////////////////////////////////////////////////////////////

   mux_store mux_store_inst (imm_S, funct3, imm_s_out);

   wire [SIZE_MEM-1:0]		  imm_s_out;
   ////////////////////////////////////////////////////////////

   block_mem #(.SIZE_ADDR_MEM(SIZE_ADDR_MEM), .SIZE_MEM(SIZE_MEM))
   block_mem_inst(clk, reset,
		  signal_store,
		  add_out,
		  add_out,
		  imm_s_out,
		  mem);

   wire [SIZE_MEM-1:0]	  mem;

   ////////////////////////////////////////////////////////////

   mux_load mux_load_inst (mem, funct3, data);

endmodule
