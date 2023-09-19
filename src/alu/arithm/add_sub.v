`ifndef __ADD_SUB__
 `define __ADD_SUB__

`include "src/routing/replicator.v"
`include "src/primitive/gate/gate_xor.v"
`include "src/alu/arithm/addX.v"

module add_sub(a, b, cin, sub, out, cout);
   parameter WIRE = 8;

   input [WIRE-1:0] a, b;
   input 	    cin, sub;

   output [WIRE-1:0] out;
   output 	     cout;

   wire 	     line;
   wire [WIRE-1:0]   b_line;
   wire [WIRE-1:0]   sub_repliq;

   or or0(line, cin, sub);
   replicator   #(.WAY(WIRE), .WIRE(1)) replicator_inst(sub_repliq, sub);
//   gate_xor     #(.WAY(2), .WIRE(WIRE)) xor_inst (b_line, {b, sub_repliq});
   xor xor0(b_line[0], b[0], sub_repliq[0]);
   xor xor1(b_line[1], b[1], sub_repliq[1]);
   xor xor2(b_line[2], b[2], sub_repliq[2]);
   xor xor3(b_line[3], b[3], sub_repliq[3]);
   xor xor4(b_line[4], b[4], sub_repliq[4]);
   xor xor5(b_line[5], b[5], sub_repliq[5]);
   xor xor6(b_line[6], b[6], sub_repliq[6]);
   xor xor7(b_line[7], b[7], sub_repliq[7]);
   addX         #(.WIRE(WIRE)) addX_inst (a, b_line, line, out, cout);
endmodule

`endif
