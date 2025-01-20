module I_imm_decoder(input [11:0] imm11_0,
		     output [31:0] I_imm);

   assign I_imm = {20'b0, imm11_0[11], imm11_0[10:0]};
endmodule
