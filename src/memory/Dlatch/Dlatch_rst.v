`ifndef __DLATCH_RST__
 `define __DLATCH_RST__

 `include "src/memory/Dlatch/parallel_Dlatch/parallel_Dlatch_rst.v"
 `include "src/memory/Dlatch/serial_Dlatch/serial_Dlatch_rst.v"

module Dlatch_rst(D, clk, rst, Q, QN);
   parameter WAY = 1;
   parameter WIRE = 1;

   input [WAY -1: 0] clk, rst;
   input [WAY*WIRE-1 : 0] D;
   output [WAY*WIRE-1:0]  Q, QN;

   wire [5:0]		      line;

   if (WAY > 1)
     parallel_Dlatch_rst #(.WAY(WAY), .WIRE(WIRE)) parallel_Dlatch_rst_inst(.D(D),
									    .clk(clk),
									    .rst(rst),
									    .Q(Q),
									    .QN(QN));
   else if (WIRE > 1)
     serial_Dlatch_rst #(.WIRE(WIRE)) inst0(.D(D),
					    .clk(clk),
					    .rst(rst),
					    .Q(Q),
					    .QN(QN));
   else
     begin
	not not0(line[0], clk);
	nor nor0(line[1], D, line[0]);
	nor nor1(line[2], line[1], line[5]);

	and and2(line[3], clk, D);
	nor nor3(line[4], line[3], line[2]);
	or  or4 (line[5], line[4], rst);

	assign Q = line[2];
	assign QN = line[5];
     end

endmodule

`endif
