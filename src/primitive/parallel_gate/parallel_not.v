`ifndef __PARALLEL_NOT__
 `define __PARALLEL_NOT__

 `include "src/primitive/serial_gate/serial_nor.v"

module parallel_not(out, A);
   parameter WAY = 1;
   parameter WIRE = 3;

   input  [WIRE-1 : 0] A;
   output [WAY*WIRE-1 : 0] out;

//   not not2(out[0], A[0]);
   serial_not not1(out[0], A[WIRE-1:0]);
   if (WIRE > 1)
     parallel_not #(.WIRE(WIRE-1))parallel_not0(out[WIRE-1 : 1],
						A[WIRE-1 : 1]);
endmodule // parallel_not

`endif
