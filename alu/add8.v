module add8 (a, b, cin, sub, s, cout);
   input [7:0] a, b;
   input       cin, sub;

   output [7:0] s;
   output 	cout;

   wire [6:0] 	ret;

   full_add add0 (a[0], b[0], cin, sub, s[0], ret[0]);
   full_add add1 (a[1], b[1], ret[0], sub, s[1], ret[1]);
   full_add add2 (a[2], b[2], ret[1], sub, s[2], ret[2]);
   full_add add3 (a[3], b[3], ret[2], sub, s[3], ret[3]);
   full_add add4 (a[4], b[4], ret[3], sub, s[4], ret[4]);
   full_add add5 (a[5], b[5], ret[4], sub, s[5], ret[5]);
   full_add add6 (a[6], b[6], ret[5], sub, s[6], ret[6]);
   full_add add7 (a[7], b[7], ret[6], sub, s[7], cout);
endmodule // add8
