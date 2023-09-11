module add_sub(a, b, cin, sub, out, cout);
   parameter SIZE = 8;

   input [SIZE-1:0] a, b;
   input 	    cin, sub;

   output [SIZE-1:0] out;
   output 	     cout;

   wire 	     line;
   wire [SIZE-1:0]   b_line;
   wire [SIZE-1:0]   sub_repliq;

   or or0(line, cin, sub);

   serial_buf #(.SIZE(SIZE)) replicator(sub_repliq, sub);
   parallel_xor #(.SIZE(SIZE)) xor8 (b_line, b, sub_repliq);
   addX         #(.SIZE(SIZE)) add8 (a, b_line, line, out, cout);
endmodule
