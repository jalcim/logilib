`ifndef __PARALLEL_DLATCH_RST_PRE__
 `define __PARALLEL_DLATCH_RST_PRE__

`include "src/memory/Dlatch/Dlatch_rst_pre.v"
`include "src/memory/Dlatch/serial_Dlatch/serial_Dlatch_rst_pre.v"

module parallel_Dlatch_rst_pre(D, clk, rst, pre, Q, QN);
   parameter WAY = 1;
   parameter WIRE = 1;

   input [WAY-1:0] clk, rst;
   input  [WAY*WIRE-1 : 0] D, pre;
   output [WAY*WIRE-1 : 0] Q, QN;

   serial_Dlatch_rst_pre #(.WIRE(WIRE)) Dlatch1(.D(D[WIRE-1:0]),
						.rst(rst[0]),
						.pre(pre[WIRE-1:0]),
						.clk(clk[0]),
						.Q(Q[WIRE-1:0]),
						.QN(QN[WIRE-1:0]));

   if (WAY > 1)
     parallel_Dlatch_rst_pre #(.WAY(WAY-1), .WIRE(WIRE)) parallel_Dlatch0(.D(D[WAY*WIRE-1 : WIRE]),
									  .clk(clk[WAY-1:1]),
									  .rst(rst[WAY-1:1]),
									  .pre(pre[WAY*WIRE-1:WIRE]),
									  .Q(Q[WAY*WIRE-1 : WIRE]),
									  .QN(QN[WAY*WIRE-1 : WIRE]));
endmodule

`endif
