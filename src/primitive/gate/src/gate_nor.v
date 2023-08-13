module gate_nor(out, in1, in2);
   input in1, in2;
   output out;

   nor nor_inst(out, in1, in2);
endmodule
