module gate_xor(out, in1, in2);
   input in1, in2;
   output out;

   xor xor_inst(out, in1, in2);
endmodule
