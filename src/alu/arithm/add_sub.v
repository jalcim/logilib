`ifndef __ADD_SUB__
 `define __ADD_SUB__

`include "src/routing/replicator.v"
`include "src/primitive/gate/gate_xor.v"
`include "src/alu/arithm/addX.v"

module add_sub(i_datain_A, i_datain_B, i_cin, i_sub, o_out, o_cout);
   parameter WIRE = 8;

   input [WIRE-1:0] i_datain_A, i_datain_B;
   input 	    i_cin, i_sub;

   output [WIRE-1:0] o_out;
   output 	     o_cout;

   wire 	     w_line;
   wire [WIRE-1:0]   w_line_b;
   wire [WIRE-1:0]   w_sub_repliq;
   wire		     w_line1, w_line2;

   or or0(w_line, i_cin, i_sub);
   replicator   #(.WAY(WIRE), .WIRE(1)) replicator_inst(w_sub_repliq, i_sub);
   gate_xor     #(.WAY(2), .WIRE(WIRE)) xor_inst (w_line_b, {i_datain_B, w_sub_repliq});
   addX         #(.WIRE(WIRE)) addX_inst (i_datain_A, w_line_b, w_line, o_out, w_line1);
   not not1 (w_line2, w_line1);
   nor nor2 (o_cout, w_line2, i_sub);
endmodule

`endif
