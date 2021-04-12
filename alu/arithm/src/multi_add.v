module multi_add(a, b, cin, sub, s, cout);
   parameter S = 3;
   parameter X = 0;

   input [2**S - 1:0] a, b;
   input 		 cin, sub;

   output [2**S -1:0] 	 s;
   output 		 cout;

   wire 		 line_c;

   if (S <= 0)
     add add0(a, b, cin, sub, s, cout);
   else if (S == 1)
     begin
	wire [1:0] b_line;
	
	gate_xor xor0(b[0], sub, b_line[0]);
	add add1(a[0], b_line[0], cin, sub, s[0], line_c);

	gate_xor xor0(b[1], sub, b_line[1]);
	add add2(a[1], b_line[1], line_c, sub, s[1], cout);
     end
   else
     begin
	if (!X)
	  begin
	     wire first;
	     gate_or or0(cin, sub, first);
	     multi_add #(.S(S-1), .X(X+1)) multi_addfirst(a[2**(S-1)-1:0],
							  b[2**(S-1)-1:0],
							  first, sub,
							  s[2**(S-1)-1:0],
							  line_c);
	  end
	else
	  begin
	     multi_add #(.S(S-1), .X(X+1)) multi_add0(a[2**(S-1)-1:0],
							b[2**(S-1)-1:0],
							cin, sub,
							s[2**(S-1)-1:0],
							line_c);
	  end
	multi_add #(.S(S-1), .X(X+1)) multi_add1(a[2**S-1:2**(S-1)],
						 b[2**S-1:2**(S-1)],
						 line_c, sub,
						 s[2**S-1:2**(S-1)],
						 cout);
     end
endmodule // multi_add
