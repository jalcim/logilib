`ifndef __PARALLEL_BUF__
 `define __PARALLEL_BUF__

module parallel_buf(out, A);
   parameter WIRE = 1;

   input  [WIRE-1:0] A;
   output [WIRE-1:0] out;

   buf buf_inst(out[0], A[0]);
   if (WIRE > 1)
     parallel_buf #(.WIRE(WIRE-1)) parallel_buf0(out[WIRE-1 : 1],
					         A[WIRE-1 : 1]);
endmodule // parallel_buf

`endif
