module lui(input [31:0] imm_u,
	   output [31:0] out);
   
   assign out = {imm_u[19:0], 12'b0};
endmodule
