`ifndef __DLATCH_RST_PRE__
 `define __DLATCH_RST_PRE__

 `include "src/memory/dlatch/parallel/parallel_Dlatch_rst_pre.v"
 `include "src/memory/dlatch/serial/serial_Dlatch_rst_pre.v"

module Dlatch_rst_pre(D, clk, rst, pre, Q, QN);
   parameter WAY = 1;
   parameter WIRE = 1;

   input [WAY -1: 0] clk, rst;
   input [WAY*WIRE -1 : 0] D, pre;
   output [WAY*WIRE -1:0]  Q, QN;

   if (WAY > 1)
     parallel_Dlatch_rst_pre #(.WAY(WAY), .WIRE(WIRE)) parallel_Dlatch_rst_pre_inst(.D(D),
										    .clk(clk),
										    .rst(rst),
										    .pre(pre),
										    .Q(Q),
										    .QN(QN));
   else
     serial_Dlatch_rst_pre #(.WIRE(WIRE)) inst0(.D(D),
						.clk(clk),
						.rst(rst),
						.pre(pre),
						.Q(Q),
						.QN(QN));
endmodule

`endif
