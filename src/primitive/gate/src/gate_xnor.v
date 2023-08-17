module gate_xnor(out, in);
   parameter SIZE = 2;
   input [1:0] in;
   output out;

   if (SIZE == 2)
     xnor xnor_inst(out, in[0], in[1]);
   else if (SIZE > 2)
     serial_xnor #(.SIZE(SIZE)) serial_xnor_inst(out, in);
endmodule
