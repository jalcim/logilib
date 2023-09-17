`ifndef __ADD_SUB__
 `define __ADD_SUB__

`include "src/routing/replicator.v"
`include "src/primitive/serial_gate/parallel_xor.v"
`include "src/alu/arithm/addx.v"

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

   replicator   #(.SIZE(SIZE)) replicator(sub_repliq, sub);
   parallel_xor #(.SIZE(SIZE)) xor8 (b_line, b, sub_repliq);
   addX         #(.SIZE(SIZE)) add8 (a, b_line, line, out, cout);
endmodule

`endif
