`ifndef __SERIAL_DFLIPFLOP__
 `define __SERIAL_DFLIPFLOP__

 `include "src/memory/dflipflop/Dflipflop.v"

module serial_Dflipflop(D, clk, Q, QN);
   parameter WIRE = 1;

   input	  clk;
   input [WIRE -1:0] D;
   output [WIRE -1:0] Q, QN;

   Dflipflop Dflipflop_inst(.D(D[0]),
			    .clk(clk),
			    .Q(Q[0]),
			    .QN(QN[0]));
   if (WIRE > 1)
     serial_Dflipflop #(.WIRE(WIRE-1)) recall(.D(D[WIRE-1:1]),
					      .clk(clk),
					      .Q(Q[WIRE-1:1]),
					      .QN(QN[WIRE-1:1]));
endmodule

`endif
