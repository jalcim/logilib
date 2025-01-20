module B_imm_decoder (input	   imm12,
		      input	    imm11,
		      input [5:0]   imm10_5,
		      input [3:0]   imm4_1,
		      output [31:0] B_imm);

   assign B_imm = {19'b0, imm12, imm11,
		   imm10_5, imm4_1, 1'b0};
endmodule
