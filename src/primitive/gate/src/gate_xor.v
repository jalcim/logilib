module gate_xor(out, in);
   parameter SIZE = 2;
   input [1:0] in;
   output out;

   if (SIZE == 2)
     xor xor_inst(out, in[0], in[1]);
   else if (SIZE > 2)
     serial_xor #(.SIZE(SIZE)) serial_xor_inst(out, in);
endmodule
