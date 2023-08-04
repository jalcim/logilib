module multX(A, B, C, out);
   parameter SIZE = 8;
   parameter ELEM = SIZE;

   input  [ELEM-1:0] A;
   input  [SIZE-1:0] B;
   input  [SIZE-1:0] C;

   output [ELEM-1:0] out;

   wire [SIZE-1:0]   div;

   if (ELEM > 1)
     begin
	if (SIZE == ELEM)
	  begin
	     supply0 [SIZE-1:0] ignore;
	     mult_cell #(.SIZE(SIZE)) inst_mult_cells(A[0], B, ignore, div, out[0]);
	  end
	else
	  mult_cell #(.SIZE(SIZE)) inst_mult_cells(A[0], B, C, div, out[0]);
	multX #(.SIZE(SIZE), .ELEM(ELEM-1)) inst_multX(A[ELEM-1:1],
						       B, div,//div == C
						       out[ELEM-1:1]);
     end
endmodule
