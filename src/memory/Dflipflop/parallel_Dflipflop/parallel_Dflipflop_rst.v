`ifndef __PARALLEL_DFLIPFLOP_RST__
 `define __PARALLEL_DFLIPFLOP_RST__

`include "src/memory/Dflipflop/Dflipflop_rst.v"
`include "src/memory/Dflipflop/serial_Dflipflop/serial_Dflipflop_rst.v"

module parallel_Dflipflop_rst(D, clk, rst, Q, QN);
   parameter WAY = 1;
   parameter WIRE = 1;

   input [WAY-1:0] clk, rst;
   input  [(WAY*WIRE)-1 : 0] D;
   output [(WAY*WIRE)-1 : 0] Q, QN;

   serial_Dflipflop_rst #(.WIRE(WIRE)) Dflipflop1(.D(D[WIRE-1:0]),
						  .clk(clk[0]),
						  .rst(rst[0]),
						  .Q(Q[WIRE-1:0]),
						  .QN(QN[WIRE-1:0]));
   if (WAY > 1)
     parallel_Dflipflop_rst #(.WAY(WAY-1), .WIRE(WIRE)) parallel_Dflipflop0(.D(D[WAY*WIRE-1 : WIRE]),
									    .clk(clk[WAY-1:1]),
									    .rst(rst[WAY-1:1]),
									    .Q(Q[WAY*WIRE-1 : WIRE]),
									    .QN(QN[WAY*WIRE-1 : WIRE]));
endmodule

`endif
