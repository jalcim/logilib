module U_imm_decoder (output [31:0] U_imm,
		      input [19:0] imm31_12);

   assign U_imm = {imm31_12, 12'b0};
endmodule
