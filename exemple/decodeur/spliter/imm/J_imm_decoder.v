module J_imm_decoder (output [31:0] J_imm,
		      input	   imm20,
		      input [7:0]  imm19_12,
		      input	   imm11,
		      input [10:1] imm10_1);

   assign J_imm = {11'b0,  imm20 , imm19_12,
		   imm11  , imm10_1, 1'b0};
endmodule
