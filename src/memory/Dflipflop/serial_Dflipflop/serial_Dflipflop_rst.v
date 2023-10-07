`ifndef __SERIAL_DFLIPFLOP__
 `define __SERIAL_DFLIPFLOP__

 `include "src/memory/Dflipflop/Dflipflop_rst.v"

module serial_Dflipflop_rst(D, clk, rst, Q, QN);
   parameter WIRE = 1;

   input [WIRE -1:0] D;
   input	     clk, rst;
   output [WIRE -1:0] Q, QN;

   Dflipflop_rst latch1(.D(D[0]),
			.clk(clk),
			.rst(rst),
			.Q(Q[0]),
			.QN(QN[0]));
   if (WIRE > 1)
     serial_Dflipflop_rst #(.WIRE(WIRE-1)) recall(.D(D[WIRE-1:1]),
						  .clk(clk),
						  .rst(rst),
						  .Q(Q[WIRE-1:1]),
						  .QN(QN[WIRE-1:1]));
endmodule

`endif
