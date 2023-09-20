`ifndef __MULTX__
 `define  __MULTX__

 `include "src/alu/arithm/mult_cell.v"

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
	  begin
	     supply0 [WIRE-1:0] ignore;
	     mult_cell #(.WIRE(WIRE)) inst_mult_cells(A[0], B, ignore, div, out[0]);
	  end
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
