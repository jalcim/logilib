`ifndef __SERIAL_DFLIPFLOP__
 `define __SERIAL_DFLIPFLOP__

 `include "src/memory/dflipflop/Dflipflop.v"

module serial_Dflipflop(D, clk, Q, QN);
   parameter WIRE = 1;

   input	  clk;
   input [WIRE -1:0] D;
   output [WIRE -1:0] Q, QN;

   /* verilator lint_off UNOPTFLAT *//* verilator lint_off UNOPTFLAT */
   wire [5:0]	      line;

   /* verilator lint_off UNOPTFLAT */
   wire		      line2;

   assign line[0] = ~(line[3] | line[1]);
   assign line[1] = ~(line[0] | clk);
   assign line2 = ~(line[1] | clk | line[3]);
   assign line[3] = ~(line2 | D[0]);

   assign line[4] = ~(line[1] | line[5]);
   assign line[5] = ~(line[4] | line2);

   assign Q[0] = line[4];
   assign QN[0] = line[5];

   if (WIRE > 1)
     serial_Dflipflop #(.WIRE(WIRE-1)) recall(.D(D[WIRE-1:1]),
					      .clk(clk),
					      .Q(Q[WIRE-1:1]),
					      .QN(QN[WIRE-1:1]));
endmodule

`endif
