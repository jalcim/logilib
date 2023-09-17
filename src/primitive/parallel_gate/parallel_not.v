`ifndef __PARALLEL_NOT__
 `define __PARALLEL_NOT__

 `include "src/primitive/serial_gate/serial_nor.v"

module parallel_not(out, A);
   parameter WAY = 1;

   input  [WAY-1:0] A;
   output [WAY-1:0] out;

   not not_inst(out[0], A[0]);
   if (WAY > 1)
     parallel_not #(.WAY(WAY-1))parallel_not0(out[WAY-1 : 1],
					        A[WAY-1 : 1]);
endmodule // parallel_not

`endif
