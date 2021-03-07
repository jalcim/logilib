module gate_buf (e1, s);
   input e1;
   output s;

   buf buf0(s, e1);
endmodule // gate_buf

module gate_not (e1, s);
   input e1;
   output s;

   not not0(s, e1);
//   assign s = ~e1;
endmodule // not

module gate_and (e1, e2, s);
   input e1;
   input e2;
   output s;

   and and0(s, e1, e2);
//   assign s = e1 & e2;
endmodule // and

module gate_or (e1, e2, s);
   input e1, e2;
   output s;

   or or0(s, e1, e2);
//   assign s = e1 | e2;
endmodule // or

module gate_xor (e1, e2, s);
   input e1, e2;
   output s;

   xor xor0(s, e1 ,e2);
//   assign s = e1 ^ e2;
endmodule // xor

module gate_xnor (e1, e2, s);
   input e1, e2;
   output s;

   xnor xnor0(s, e1 ,e2);
//   assign s = ~(e1 ^ e2);
endmodule // xor

module gate_nand (e1, e2, s);
   input e1, e2;
   output s;

   nand nand0(s, e1, e2);
//   assign s = ~(e1 & e2);
endmodule // nand
  
module gate_nor (e1, e2, s);
   input e1, e2;
   output s;

   nor nor0(s, e1, e2);
//   assign s = ~(e1 | e2);
endmodule // nor
