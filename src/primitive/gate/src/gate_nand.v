module gate_nand(out, in);
   parameter SIZE = 2;
   input [1:0] in;
   output out;

   nand nand_inst(out, in[0], in[1]);
endmodule
