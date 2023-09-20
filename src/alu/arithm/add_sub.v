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
   gate_xor     #(.WAY(2), .WIRE(WIRE)) xor_inst (b_line, {b, sub_repliq});
   addX         #(.WIRE(WIRE)) addX_inst (a, b_line, line, out, cout);
endmodule

`endif
