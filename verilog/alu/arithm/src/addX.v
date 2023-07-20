module add_sub(a, b, cin, sub, out, cout);
   parameter SIZE = 8;

   input [SIZE-1:0] a, b;
   input 	    cin, sub;

   output [SIZE-1:0] out;
   output 	     cout;

   wire 	     line;
   wire [SIZE-1:0]   b_line;
   wire [SIZE-1:0]   sub_repl;

   or or0(line, cin, sub);

   serial_buf #(.SIZE(SIZE)) replicator(sub_repl, sub);
   parallel_xor #(.SIZE(SIZE)) xor8 (b_line, b, sub_repl);
   addX         #(.SIZE(SIZE)) add8 (a, b_line, cin, out, cout);
endmodule

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
