module jal(input [31:0] pc,
	   input [31:0]	 imm_j,
	   output [31:0] jal_out,
	   output [31:0] ret);

   assign ret = pc + 32'd4;
   assign jal_out = pc + {{11{imm_j[20]}}, imm_j[20:0], 1'b0};
endmodule
