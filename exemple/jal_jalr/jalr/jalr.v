module jalr(input [31:0] rs1,
	    input [31:0]  imm_i,
	    output [31:0] jal_out,
	    output [31:0] ret);
   wire [31:0]		  tmp;
   
   assign ret = rs1 + 32'd4;
   assign tmp = (rs1 + {{20{imm_i[11]}}, imm_i[11:0]});
   assign jal_out = {tmp[31:1], 1'b0};
endmodule
