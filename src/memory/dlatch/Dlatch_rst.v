`ifndef __DLATCH_RST__
 `define __DLATCH_RST__

 `include "src/memory/dlatch/parallel/parallel_Dlatch_rst.v"
 `include "src/memory/dlatch/serial/serial_Dlatch_rst.v"

module Dlatch_rst(D, clk, rst, Q, QN);
   parameter WAY = 1;
   parameter WIRE = 1;

   input [WAY -1: 0] clk, rst;
   input [WAY*WIRE-1 : 0] D;
   output [WAY*WIRE-1:0]  Q, QN;

   if (WAY > 1)
     parallel_Dlatch_rst #(.WAY(WAY), .WIRE(WIRE)) parallel_Dlatch_rst_inst(.D(D),
									    .clk(clk),
									    .rst(rst),
									    .Q(Q),
									    .QN(QN));
   else
     serial_Dlatch_rst #(.WIRE(WIRE)) inst0(.D(D),
					    .clk(clk),
					    .rst(rst),
					    .Q(Q),
					    .QN(QN));

endmodule

`endif
