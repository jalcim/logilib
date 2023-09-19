`ifndef __MULT_CELL__
 `define __MULT_CELL__

 `include "src/routing/replicator.v"

 `include "src/alu/arithm/divmod2.v"
 `include "src/alu/arithm/addX.v"
 `include "src/primitive/gate/gate_and.v"

module mult_cell(A, B, C, div2, mod2);
   parameter WIRE = 8;

   input [WIRE-1:0] B, C;
   input	    A;

   output [WIRE-1:0] div2;
   output mod2;

   supply0 padding;
   wire [WIRE-1:0] line;
   wire		   ignored;
   wire [WIRE-1:0] A_repliq;
   wire [WIRE-1:0] b_line;

   replicator #(.WAY(WIRE), .WIRE(1)) replicator(A_repliq, A);
   gate_and #(.WAY(2), .WIRE(WIRE)) inst_and(b_line, {B, A_repliq});
   addX #(.WIRE(WIRE)) inst_add(B, C, padding, line, ignored);
   divmod2 #(.WIRE(WIRE)) inst_divmod2(line, div2, mod2);
endmodule

`endif
