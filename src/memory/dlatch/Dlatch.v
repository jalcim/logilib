`ifndef __DLATCH__
 `define __DLATCH__

 `include "src/memory/dlatch/parallel/parallel_Dlatch.v"
 `include "src/memory/dlatch/serial/serial_Dlatch.v"

module Dlatch (D, clk, Q, QN);
   parameter WAY = 1;
   parameter WIRE = 1;

   input [WAY -1: 0] clk;
   input [(WAY * WIRE)-1 : 0] D;
   output [(WAY * WIRE)-1:0]  Q, QN;

   if (WAY > 1)
     parallel_Dlatch #(.WAY(WAY), .WIRE(WIRE)) parallel_Dlatch_inst(.D(D),
								    .clk(clk),
								    .Q(Q),
								    .QN(QN));
   else
     serial_Dlatch #(.WIRE(WIRE)) inst0(.D(D),
					.clk(clk),
					.Q(Q),
					.QN(QN));

endmodule

`endif
