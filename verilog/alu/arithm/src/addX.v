module addX (a, b, cin, out, cout);
   parameter SIZE = 8;

   input [SIZE-1:0] a, b;
   input 	    cin;

   output [SIZE-1:0] out;
   output 	     cout;

   wire 	     ret;

   if (SIZE > 1)
     begin
	add add0 (a[0], b[0], cin, out[0], ret);
	addX #(.SIZE(SIZE-1)) recall(a[SIZE-1:1],
				     b[SIZE-1:1],
				     ret,
				     out[SIZE-1:1],
				     cout);
     end
   else
     add add0 (a[0], b[0], cin, out[0], cout);
endmodule
