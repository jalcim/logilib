module gate_or(out, in);
   parameter SIZE = 2;
   input [1:0] in;
   output out;

   or or_inst(out, in[0], in[1]);
endmodule
