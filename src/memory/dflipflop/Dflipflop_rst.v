`ifndef __DFLIPFLOP_RST__
 `define __DFLIPFLOP_RST__

 `include "src/memory/dflipflop/parallel/parallel_Dflipflop_rst.v"
 `include "src/memory/dflipflop/serial/serial_Dflipflop_rst.v"

module Dflipflop_rst(D, clk, rst, Q, QN);
   parameter WAY = 1;
   parameter WIRE = 1;

   input [WAY*WIRE -1:0] D;
   input [WAY-1:0] clk, rst;
   output [WAY*WIRE-1:0] Q, QN;

    if (WAY > 1)
        begin
            parallel_Dflipflop_rst #(.WAY(WAY), .WIRE(WIRE))
            parallel_Dflipflop_inst(.D(D),
	        .clk(clk),
	        .rst(rst),
	        .Q(Q),
	        .QN(QN));
    else
        begin
            serial_Dflipflop_rst #(.WIRE(WIRE))
            inst0(.D(D),
	        .clk(clk),
	        .rst(rst),
	        .Q(Q),
	        .QN(QN));
        end
endmodule

`endif
