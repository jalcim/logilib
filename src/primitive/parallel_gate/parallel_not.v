`ifndef __PARALLEL_NOT__
 `define __PARALLEL_NOT__

module parallel_not(out, A);
   parameter WIRE = 1;

   input  [WIRE-1:0] A;
   output [WIRE-1:0] out;

   not not_inst(out[0], A[0]);
   if (WIRE > 1)
     parallel_not #(.WIRE(WIRE-1))parallel_not0(out[WIRE-1 : 1],
					        A[WIRE-1 : 1]);
endmodule // parallel_not

`endif
