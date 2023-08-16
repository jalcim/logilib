module gate_and(out, in);
   parameter SIZE = 2;
   input [1:0] in;
   output out;

   and and_inst(out, in[0], in[1]);
endmodule
