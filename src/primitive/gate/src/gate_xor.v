module gate_xor(out, in);
   parameter SIZE = 2;
   input [1:0] in;
   output out;

   xor xor_inst(out, in[0], in[1]);
endmodule
