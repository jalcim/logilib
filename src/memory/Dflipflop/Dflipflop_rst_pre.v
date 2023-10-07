`ifndef __DFLIPFLOP_PRE_RST_
 `define __DFLIPFLOP_PRE_RST_

 `include "src/memory/Dflipflop/parallel_Dflipflop_rst_pre.v"
 `include "src/memory/Dflipflop/serial_Dflipflop_rst_pre.v"

module Dflipflop_rst_pre(D, clk, rst, pre, Q, QN);
   parameter WAY = 1;
   parameter WIRE = 1;

   input [WAY-1:0] rst, clk;
   input [WAY*WIRE -1:0] D, pre;
   output [WAY-1:0]	 Q, QN;

   wire [5:0]		 line;

   if (WAY > 1)
     parallel_Dflipflop #(.WAY(WAY), .WIRE(WIRE)) parallel_Dflipflop_inst(.D(D),
									  .clk(clk),
									  .rst(rst),
									  .pre(pre),
									  .Q(Q),
									  .QN(QN));
   else if (WIRE > 1)
     serial_Dflipflop #(.WIRE(WIRE)) inst0(.D(D),
					   .clk(clk),
					   .rst(rst),
					   .pre(pre),
					   .Q(Q),
					   .QN(QN));
   else
     begin
	assign line[0] = ~(rst | line[3] | line[2]);
	assign line[1] = ~(line[2] | clk | line[3]);
	assign line[2] = ~(line[0] | pre | clk);
	assign line[3] = ~(line[1] | D | pre);

	assign line[4] = ~(rst | line[2] | line[5]);
	assign line[5] = ~(line[4] | line[1] | pre);

	assign Q = line[4];
	assign QN = line[5];
     end
endmodule

`endif
