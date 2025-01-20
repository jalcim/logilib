module S_imm_decoder (input [4:0] imm4_0,
		      input [6:0]   imm11_5,
		      output [31:0] S_imm);

   assign S_imm = {imm11_5[6], 20'b0, imm11_5[5:0], imm4_0};
endmodule
