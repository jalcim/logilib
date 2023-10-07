`ifndef __DLATCH_RST_PRE__
 `define __DLATCH_RST_PRE__

 `include "src/memory/Dlatch/parallel_Dlatch/parallel_Dlatch_rst_pre.v"
 `include "src/memory/Dlatch/serial_Dlatch/serial_Dlatch_rst_pre.v"

module Dlatch_rst_pre(D, clk, rst, pre, Q, QN);
   parameter WAY = 1;
   parameter WIRE = 1;

   input [WAY -1: 0] clk, rst;
   input [WAY*WIRE -1 : 0] D, pre;
   output [WAY*WIRE -1:0]  Q, QN;

   wire [6:0]		      line;

   if (WAY > 1)
     parallel_Dlatch_rst_pre #(.WAY(WAY), .WIRE(WIRE)) parallel_Dlatch_rst_pre_inst(.D(D),
										    .clk(clk),
										    .rst(rst),
										    .pre(pre),
										    .Q(Q),
										    .QN(QN));
   else if (WIRE > 1)
     serial_Dlatch_rst_pre #(.WIRE(WIRE)) inst0(.D(D),
						.clk(clk),
						.rst(rst),
						.pre(pre),
						.Q(Q),
						.QN(QN));
   else
     begin
	not not0(line[0], clk);
	nor nor0(line[1], D, line[0]);
	nor nor1(line[2], line[1], line[6]);
	or  or2 (line[3], line[2], pre);

	and and3(line[4], clk, D);
	nor nor4(line[5], line[4], line[3]);
	or  or5 (line[6], line[5], rst);

	assign Q = line[3];
	assign QN = line[6];
     end

endmodule

`endif
