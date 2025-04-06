`ifndef __PARALLEL_DFLIPFLOP_PRE__
 `define __PARALLEL_DFLIPFLOP_PRE__

`include "src/memory/dflipflop/Dflipflop_pre.v"
`include "src/memory/dflipflop/serial/serial_Dflipflop_pre.v"

module parallel_Dflipflop_pre(D, clk, pre, Q, QN);
   parameter WAY = 1;
   parameter WIRE = 1;

   input [WAY-1:0] clk;
   input  [WAY*WIRE-1 : 0] D, pre;
   output [WAY*WIRE-1 : 0] Q, QN;

   serial_Dflipflop_pre #(.WIRE(WIRE)) Dflipflop1(.D(D[WIRE-1:0]),
						  .clk(clk[0]),
						  .pre(pre[WIRE-1:0]),
						  .Q(Q[WIRE-1:0]),
						  .QN(QN[WIRE-1:0]));
   if (WAY > 1)
     parallel_Dflipflop_pre #(.WAY(WAY-1), .WIRE(WIRE)) parallel_Dflipflop0(.D(D[WAY*WIRE-1 : WIRE]),
									    .clk(clk[WAY-1:1]),
									    .pre(pre[WAY*WIRE-1:WIRE]),
									    .Q(Q[WAY*WIRE-1 : WIRE]),
									    .QN(QN[WAY*WIRE-1 : WIRE]));
endmodule

`endif
