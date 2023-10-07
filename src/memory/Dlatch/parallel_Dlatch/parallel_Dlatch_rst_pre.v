`ifndef __PARALLEL_DLATCH_RST_PRE__
 `define __PARALLEL_DLATCH_RST_PRE__

`include "src/memory/Dlatch/Dlatch_rst_pre.v"
`include "src/memory/Dlatch/serial_Dlatch/serial_Dlatch_rst_pre.v"

module parallel_Dlatch_pre(D, clk, rst, pre, Q, QN);
   parameter WAY = 1;
   parameter WIRE = 1;

   input [WAY-1:0] clk, rst;
   input  [WAY*WIRE-1 : 0] D, pre;
   output [WAY*WIRE-1 : 0] Q, QN;

   if (WIRE == 1)
     Dlatch_pre Dlatch0(D[0], clk[0], pre[0], rst[0], Q[0], QN[0]);
   else if (WIRE > 1)
     serial_Dlatch_pre #(.WIRE(WIRE)) Dlatch1(D[WIRE-1:0], clk[0], pre[WIRE-1:0], rst[0], Q[WIRE-1:0], QN[WIRE-1:0]);

   if (WAY > 1)
     parallel_Dlatch_pre #(.WAY(WAY-1), .WIRE(WIRE)) parallel_Dlatch0(D[WAY*WIRE-1 : WIRE],
								      clk[WAY-1:1],
								      rst[WAY-1:1],
								      pre[WAY*WIRE-1:WIRE],
								      Q[WAY*WIRE-1 : WIRE],
								      QN[WAY*WIRE-1 : WIRE]);
endmodule

`endif
