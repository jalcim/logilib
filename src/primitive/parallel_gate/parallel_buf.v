`ifndef __PARALLEL_BUF__
 `define __PARALLEL_BUF__

module parallel_buf(out, A);
   parameter WAY = 1;

   input  [WAY-1:0] A;
   output [WAY-1:0] out;

   buf buf_inst(out[0], A[0]);
   if (WAY > 1)
     parallel_buf #(.WAY(WAY-1)) parallel_buf0(out[WAY-1 : 1],
					         A[WAY-1 : 1]);
endmodule // parallel_buf

`endif
