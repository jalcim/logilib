module regdec(a, rl, s);
   input [7:0] a;
   input       rl;
   output [7:0] s;

   wire 	line_not;
   wire [13:0] 	line;
   wire [5:0]	line_or;

   gate_not not0(rl, line_not);

/////////////////////////////////////////////////////////////
   
   gate_and and0(a[0], rl, line[0]);

   gate_and and1(a[1], line_not, s[0]);
   gate_and and2(a[1], rl, line[2]);

   gate_and and3(a[2], line_not, line[3]);
   gate_and and4(a[2], rl, line[4]);

   gate_and and5(a[3], line_not, line[5]);
   gate_and and6(a[3], rl, line[6]);

   gate_and and7(a[4], line_not, line[7]);
   gate_and and8(a[4], rl, line[8]);

   gate_and and9(a[5], line_not, line[9]);
   gate_and and10(a[5], rl, line[10]);

   gate_and and11(a[6], line_not, line[11]);
   gate_and and12(a[6], rl, s[7]);

   gate_and and13(a[7], line_not, line[13]);

//////////////////////////////////////////////////////////////////

   gate_or or0(line[0], line[3], s[1]);
   gate_or or1(line[2], line[5], s[2]);
   gate_or or2(line[4], line[7], s[3]);
   gate_or or3(line[6], line[9], s[4]);
   gate_or or4(line[8], line[11], s[5]);
   gate_or or5(line[10], line[13], s[6]);



endmodule // regdec
