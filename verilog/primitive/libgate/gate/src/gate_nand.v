module gate_nand (e1, e2, s);
   input e1, e2;
   output s;

   nand nand0(s, e1, e2);
endmodule // nand
