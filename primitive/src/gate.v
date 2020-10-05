module gate_not (e1, s);
   input e1;
   output s;

   assign s = ~e1;
endmodule // not

module gate_and (e1, e2, s);
   input e1;
   input e2;
   output s;

   assign s = e1 & e2;
endmodule // and

module gate_or (e1, e2, s);
   input e1, e2;
   output s;

   assign s = e1 | e2;
endmodule // or

module gate_xor (e1, e2, s);
   input e1, e2;
   output s;
 
   assign s = e1 ^ e2;
endmodule // xor

module gate_nand (e1, e2, s);
   input e1, e2;
   output s;

   assign s = ~(e1 & e2);
endmodule // nand
  
module gate_nor (e1, e2, s);
   input e1, e2;
   output s;

   assign s = ~(e1 | e2);
endmodule // nor
