`ifndef __DLATCH_PRE__
 `define __DLATCH_PRE__

 `include "src/memory/dlatch/parallel/parallel_Dlatch_pre.v"
 `include "src/memory/dlatch/serial/serial_Dlatch_pre.v"

module Dlatch_pre(D, clk, pre, Q, QN);
   parameter WAY = 1;
   parameter WIRE = 1;

   input [WAY -1: 0] clk;
   input [WAY*WIRE-1 : 0] D, pre;
   output [WAY*WIRE-1: 0]  Q, QN;

   if (WAY > 1)
     parallel_Dlatch_pre #(.WAY(WAY), .WIRE(WIRE)) parallel_Dlatch_pre_inst(.D(D),
									    .clk(clk),
									    .pre(pre),
									    .Q(Q),
									    .QN(QN));
   else
     serial_Dlatch_pre #(.WIRE(WIRE)) inst0(.D(D),
					    .clk(clk),
					    .pre(pre),
					    .Q(Q),
					    .QN(QN));
endmodule

`endif
