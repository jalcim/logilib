module gate_buf8(e1, s);
   input [7:0] e1;
   output [7:0] s;

   gate_buf buf0(e1[0], s[0]);
   gate_buf buf1(e1[1], s[1]);
   gate_buf buf2(e1[2], s[2]);
   gate_buf buf3(e1[3], s[3]);
   gate_buf buf4(e1[4], s[4]);
   gate_buf buf5(e1[5], s[5]);
   gate_buf buf6(e1[6], s[6]);
   gate_buf buf7(e1[7], s[7]);

endmodule   

module gate_not8 (e1, s);
   input [7:0] e1;
   output [7:0] s;

   gate_not not0(e1[0], s[0]);
   gate_not not1(e1[1], s[1]);
   gate_not not2(e1[2], s[2]);
   gate_not not3(e1[3], s[3]);
   gate_not not4(e1[4], s[4]);
   gate_not not5(e1[5], s[5]);
   gate_not not6(e1[6], s[6]);
   gate_not not7(e1[7], s[7]);

endmodule // not

module gate_and8 (e1, e2, s);
   input [7:0] e1,e2;
   output [7:0] s;

   gate_and and0(e1[0], e2[0], s[0]);
   gate_and and1(e1[1], e2[1], s[1]);
   gate_and and2(e1[2], e2[2], s[2]);
   gate_and and3(e1[3], e2[3], s[3]);
   gate_and and4(e1[4], e2[4], s[4]);
   gate_and and5(e1[5], e2[5], s[5]);
   gate_and and6(e1[6], e2[6], s[6]);
   gate_and and7(e1[7], e2[7], s[7]);
   
endmodule // and

module gate_or8 (e1, e2, s);
   input [7:0] e1, e2;
   output [7:0] s;

   gate_or or0(e1[0], e2[0], s[0]);
   gate_or or1(e1[1], e2[1], s[1]);
   gate_or or2(e1[2], e2[2], s[2]);
   gate_or or3(e1[3], e2[3], s[3]);
   gate_or or4(e1[4], e2[4], s[4]);
   gate_or or5(e1[5], e2[5], s[5]);
   gate_or or6(e1[6], e2[6], s[6]);
   gate_or or7(e1[7], e2[7], s[7]);
endmodule // or

module gate_xor8 (e1, e2, s);
   input [7:0] e1, e2;
   output [7:0] s;

   gate_xor xor0(e1[0], e2[0], s[0]);
   gate_xor xor1(e1[1], e2[1], s[1]);
   gate_xor xor2(e1[2], e2[2], s[2]);
   gate_xor xor3(e1[3], e2[3], s[3]);
   gate_xor xor4(e1[4], e2[4], s[4]);
   gate_xor xor5(e1[5], e2[5], s[5]);
   gate_xor xor6(e1[6], e2[6], s[6]);
   gate_xor xor7(e1[7], e2[7], s[7]);

endmodule // xor

module gate_xnor8 (e1, e2, s);
   input [7:0] e1, e2;
   output [7:0] s;
 
   gate_xnor xnor0(e1[0], e2[0], s[0]);
   gate_xnor xnor1(e1[1], e2[1], s[1]);
   gate_xnor xnor2(e1[2], e2[2], s[2]);
   gate_xnor xnor3(e1[3], e2[3], s[3]);
   gate_xnor xnor4(e1[4], e2[4], s[4]);
   gate_xnor xnor5(e1[5], e2[5], s[5]);
   gate_xnor xnor6(e1[6], e2[6], s[6]);
   gate_xnor xnor7(e1[7], e2[7], s[7]);

endmodule // xor

module gate_nand8 (e1, e2, s);
   input [7:0] e1, e2;
   output [7:0] s;

   gate_nand nand0(e1[0], e2[0], s[0]);
   gate_nand nand1(e1[1], e2[1], s[1]);
   gate_nand nand2(e1[2], e2[2], s[2]);
   gate_nand nand3(e1[3], e2[3], s[3]);
   gate_nand nand4(e1[4], e2[4], s[4]);
   gate_nand nand5(e1[5], e2[5], s[5]);
   gate_nand nand6(e1[6], e2[6], s[6]);
   gate_nand nand7(e1[7], e2[7], s[7]);

endmodule // nand
  
module gate_nor8 (e1, e2, s);
   input [7:0] e1, e2;
   output [7:0] s;

   gate_nor nor0(e1[0], e2[0], s[0]);
   gate_nor nor1(e1[1], e2[1], s[1]);
   gate_nor nor2(e1[2], e2[2], s[2]);
   gate_nor nor3(e1[3], e2[3], s[3]);
   gate_nor nor4(e1[4], e2[4], s[4]);
   gate_nor nor5(e1[5], e2[5], s[5]);
   gate_nor nor6(e1[6], e2[6], s[6]);
   gate_nor nor7(e1[7], e2[7], s[7]);

endmodule // nor
