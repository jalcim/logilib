module multi_add(a, b, cin, sub, s, cout);
   parameter S = 3;

   input [2**S - 1:0] a, b;
   input 		 cin, sub;

   output [2**S -1:0] s;
   output 		 cout;

   wire 		 line_c;

   if (S <= 0)
     add add0(a, b, cin, sub, s, cout);
   else if (S == 1)
     begin
	add add1(a[0], b[0], cin, sub, s, line_c);
	add add2(a[1], b[1], line_c, sub, s, cout);
     end
   else
     begin
	multi_add #(.S(S-1))multi_add0(a[2**(S-1)-1:0],
				       b[2**(S-1)-1:0],
				       cin, sub, s, line_c);
	multi_add #(.S(S-1))multi_add1(a[2**S-1:2**(S-1):0],
				       b[2**S-1:2**(S-1):0],
				       line_c, sub, s, cout);
     end
endmodule // multi_add
