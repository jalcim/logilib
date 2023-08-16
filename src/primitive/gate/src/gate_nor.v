module gate_nor(out, in);
   parameter SIZE = 2;
   input [1:0] in;
   output out;

   nor nor_inst(out, in[0], in[1]);
endmodule
