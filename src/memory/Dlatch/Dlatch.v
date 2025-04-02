`ifndef __DLATCH__
 `define __DLATCH__

 `include "src/memory/Dlatch/parallel_Dlatch/parallel_Dlatch.v"
 `include "src/memory/Dlatch/serial_Dlatch/serial_Dlatch.v"

/* verilator lint_off UNOPTFLAT */
module Dlatch (D, clk, Q, QN);
   parameter WAY = 1;
   parameter WIRE = 1;

   input [WAY -1: 0] clk;
   input [(WAY * WIRE)-1 : 0] D;
   output [(WAY * WIRE)-1:0]  Q, QN;

   wire [4:0] line;

   if (WAY > 1)
     parallel_Dlatch #(.WAY(WAY), .WIRE(WIRE)) parallel_Dlatch_inst(.D(D),
								    .clk(clk),
								    .Q(Q),
								    .QN(QN));
   else if (WIRE > 1)
     serial_Dlatch #(.WIRE(WIRE)) inst0(.D(D),
					.clk(clk),
					.Q(Q),
					.QN(QN));
   else
     begin
	not not0(line[0], clk);
	nor nor0(line[1], D, line[0]);
	nor nor1(line[2], line[1], line[4]);

	and and2(line[3], D, clk);
	nor nor3(line[4], line[3], line[2]);

	assign Q  = line[2];
	assign QN = line[4];
     end

endmodule

`endif
