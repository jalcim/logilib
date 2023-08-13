module gate_nand(out, in1, in2);
   input in1, in2;
   output out;

   nand nand_inst(out, in1, in2);
endmodule
