module auipc(input [31:0] imm_u,
	     input [31:0] pc,
	     output [31:0] out);
   
   assign out = pc + {imm_u[19:0], 12'b0};
endmodule
