`ifndef __DFLIPFLOP_RST_PRE_
 `define __DFLIPFLOP_RST_PRE_

 `include "src/memory/dflipflop/parallel/parallel_Dflipflop_rst_pre.v"
 `include "src/memory/dflipflop/serial/serial_Dflipflop_rst_pre.v"

module Dflipflop_rst_pre(D, clk, rst, pre, Q, QN);
   parameter WAY = 1;
   parameter WIRE = 1;

   input [WAY-1:0] rst, clk;
   input [WAY*WIRE -1:0] D, pre;
   output [WAY*WIRE-1:0]	 Q, QN;

   wire [5:0]		 line;

   if (WAY > 1)
     parallel_Dflipflop_rst_pre #(.WAY(WAY), .WIRE(WIRE)) parallel_Dflipflop_inst(.D(D),
										  .clk(clk),
										  .rst(rst),
										  .pre(pre),
										  .Q(Q),
										  .QN(QN));
   else
     serial_Dflipflop_rst_pre #(.WIRE(WIRE)) inst0(.D(D),
						   .clk(clk),
						   .rst(rst),
						   .pre(pre),
						   .Q(Q),
						   .QN(QN));
endmodule

`endif
