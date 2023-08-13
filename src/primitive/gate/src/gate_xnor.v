module gate_xnor(out, in1, in2);
   input in1, in2;
   output out;

   xnor xnor_inst(out, in1, in2);
endmodule
