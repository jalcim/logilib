module add8 (a, b, cin, sub, s, cout);
   input [7:0] a, b;
   input       cin, sub;

   output [7:0] s;
   output 	cout;

   wire [7:0] 	b_line;
   wire [6:0] 	ret;
   wire 	line;
   
   gate_or or0(cin, sub, line);

   gate_xor xor0(b[0], sub, b_line[0]);
   add add0 (a[0], b[0], line, sub, s[0], ret[0]);
   gate_xor xor1(b[1], sub, b_line[1]);
   add add1 (a[1], b[1], ret[0], sub, s[1], ret[1]);
   gate_xor xor2(b[2], sub, b_line[2]);
   add add2 (a[2], b[2], ret[1], sub, s[2], ret[2]);
   gate_xor xor3(b[3], sub, b_line[3]);
   add add3 (a[3], b[3], ret[2], sub, s[3], ret[3]);
   gate_xor xor4(b[4], sub, b_line[4]);
   add add4 (a[4], b[4], ret[3], sub, s[4], ret[4]);
   gate_xor xor5(b[5], sub, b_line[5]);
   add add5 (a[5], b[5], ret[4], sub, s[5], ret[5]);
   gate_xor xor6(b[6], sub, b_line[6]);
   add add6 (a[6], b[6], ret[5], sub, s[6], ret[6]);
   gate_xor xor7(b[7], sub, b_line[7]);
   add add7 (a[7], b[7], ret[6], sub, s[7], cout);
endmodule // add8
