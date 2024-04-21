module I_imm(imm11_0, imm32);
   input [11:0] imm11_0;
   output [31:0] imm32;

   assign imm32 = {imm11_0[11], {20{0}}, imm11_0[10:0]};
endmodule
   
