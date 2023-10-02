`ifndef __MULTX__
 `define  __MULTX__

module multX(A, B, C, out);
   parameter WIRE = 8;
   parameter ELEM = WIRE;

   input  [ELEM-1:0] A;
   input  [WIRE-1:0] B;
   input  [WIRE-1:0] C;

   output [ELEM-1:0] out;

   wire [WIRE-1:0]   div;

   if (ELEM > 1)
     begin
	if (WIRE == ELEM)
	  mult_cell #(.WIRE(WIRE)) inst_mult_cells(A[0], B, {WIRE{1'b0}}, div, out[0]);
	else
	  mult_cell #(.WIRE(WIRE)) inst_mult_cells(A[0], B, C, div, out[0]);
	multX #(.WIRE(WIRE), .ELEM(ELEM-1)) inst_multX(A[ELEM-1:1],
						       B, div,//div == C
						       out[ELEM-1:1]);
     end
   else
     mult_cell #(.WIRE(WIRE)) inst_mult_cells(A[0], B, C, div, out[0]);
endmodule

`endif

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
   addX #(.WIRE(WIRE)) inst_add(b_line, C, padding, line, ignored);
   divmod2 #(.WIRE(WIRE)) inst_divmod2(line, div2, mod2);
endmodule

`endif
