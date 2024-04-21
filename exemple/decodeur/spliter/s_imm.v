module S_imm(imm4_0, imm11_5, imm32);
   input [4:0] imm4_0;
   input [6:0] imm21_5;
   output [31:0] imm32;

   assign imm32 = {imm11_5[6], {20{0}}, imm11_5[5:0], imm4_0};
endmodule
