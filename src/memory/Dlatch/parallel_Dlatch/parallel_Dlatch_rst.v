`ifndef __PARALLEL_DLATCH_RST__
 `define __PARALLEL_DLATCH_RST__

`include "src/memory/Dlatch/Dlatch_rst.v"
`include "src/memory/Dlatch/serial_Dlatch/serial_Dlatch_rst.v"

module parallel_Dlatch_rst(D, clk, rst, Q, QN);
   parameter WAY = 1;
   parameter WIRE = 1;

   input [WAY-1:0] clk, rst;
   input  [(WAY*WIRE)-1 : 0] D;
   output [(WAY*WIRE)-1 : 0] Q, QN;

   serial_Dlatch_rst #(.WIRE(WIRE)) Dlatch1(.D(D[WIRE-1:0]),
					    .clk(clk[0]),
					    .rst(rst[0]),
					    .Q(Q[WIRE-1:0]),
					    .QN(QN[WIRE-1:0]));

   if (WAY > 1)
     parallel_Dlatch_rst #(.WAY(WAY-1), .WIRE(WIRE)) parallel_Dlatch0(.D(D[WAY*WIRE-1 : WIRE]),
								      .clk(clk[WAY-1:1]),
								      .rst(rst[WAY-1:1]),
								      .Q(Q[WAY*WIRE-1 : WIRE]),
								      .QN(QN[WAY*WIRE-1 : WIRE]));
endmodule

`endif
