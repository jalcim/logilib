`ifndef __DFLIPFLOP_PRE__
 `define __DFLIPFLOP_PRE__

 `include "src/memory/dflipflop/parallel/parallel_Dflipflop_pre.v"
 `include "src/memory/dflipflop/serial/serial_Dflipflop_pre.v"

module Dflipflop_pre(D, clk, pre, Q, QN);
   parameter WAY = 1;
   parameter WIRE = 1;

   input [WAY*WIRE -1:0] D, pre;
   input [WAY-1:0]	 clk;
   output [WAY*WIRE-1:0] Q, QN;

   if (WAY > 1)
     parallel_Dflipflop_pre #(.WAY(WAY), .WIRE(WIRE)) parallel_Dflipflop_inst(.D(D),
									      .clk(clk),
									      .pre(pre),
									      .Q(Q),
									      .QN(QN));
   else
     serial_Dflipflop_pre #(.WIRE(WIRE)) inst0(.D(D),
					       .clk(clk),
					       .pre(pre),
					       .Q(Q),
					       .QN(QN));
endmodule

`endif
