`ifndef __DFLIPFLOP__
 `define __DFLIPFLOP__

 `include "src/memory/dflipflop/parallel/parallel_Dflipflop.v"
 `include "src/memory/dflipflop/serial/serial_Dflipflop.v"

module Dflipflop(D, clk, Q, QN);
   parameter WAY = 1;
   parameter WIRE = 1;

   input [WAY-1:0] clk;
   input [WAY*WIRE -1:0] D;
   output [WAY*WIRE-1:0] Q, QN;

   if (WAY > 1)
     parallel_Dflipflop #(.WAY(WAY), .WIRE(WIRE)) parallel_Dflipflop_inst(.D(D),
									  .clk(clk),
									  .Q(Q),
									  .QN(QN));
   else
     serial_Dflipflop #(.WIRE(WIRE)) inst0(.D(D),
					   .clk(clk),
					   .Q(Q),
					   .QN(QN));
endmodule

`endif
