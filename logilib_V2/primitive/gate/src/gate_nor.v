module gate_nor (e1, e2, s);
   input e1, e2;
   output s;

   nor nor0(s, e1, e2);
endmodule // nor
