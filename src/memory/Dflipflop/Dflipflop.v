`ifndef __DFLIPFLOP_PRE_RST__
 `define __DFLIPFLOP_PRE_RST__

 `include "src/memory/Dflipflop/parallel_Dflipflop/parallel_Dflipflop.v"
 `include "src/memory/Dflipflop/serial_Dflipflop/serial_Dflipflop.v"

module Dflipflop(D, clk, Q, QN);
   parameter WAY = 1;
   parameter WIRE = 1;

   input [WAY-1:0] clk;
   input [WAY*WIRE -1:0] D;
   output [WAY-1:0]	 Q, QN;

   wire [5:0]		 line;

   if (WAY > 1)
     parallel_Dflipflop #(.WAY(WAY), .WIRE(WIRE)) parallel_Dflipflop_inst(.D(D),
									  .clk(clk),
									  .Q(Q),
									  .QN(QN));
   else if (WIRE > 1)
        serial_Dflipflop #(.WIRE(WIRE)) inst0(.D(D),
					      .clk(clk),
					      .Q(Q),
					      .QN(QN));
   else
     begin
	assign line[0] = ~(line[3] | line[1]);
	assign line[1] = ~(line[0] | clk);
	assign line[2] = ~(line[1] | clk | line[3]);
	assign line[3] = ~(line[2] | D);

	assign line[4] = ~(line[1] | line[5]);
	assign line[5] = ~(line[4] | line[2]);

	assign Q = line[4];
	assign QN = line[5];
     end
endmodule

`endif
