`ifndef __SERIAL_DFLIPFLOP_RST__
 `define __SERIAL_DFLIPFLOP_RST_

module serial_Dflipflop_rst(D, clk, rst, Q, QN);
   parameter WIRE = 1;

   input [WIRE -1:0] D;
   input	     clk, rst;
   output [WIRE -1:0] Q, QN;

   /* verilator lint_off UNOPTFLAT */
   wire [5:0]	      line;

   /* verilator lint_off UNOPTFLAT */
   wire		      line2;

   assign line[0] = ~(rst | line[3] | line[1]);
   assign line[1] = ~(line[0] | clk);
   assign line2 = ~(line[1] | clk | line[3]);
   assign line[3] = ~(line2 | D[0]);

   assign line[4] = ~(rst | line[1] | line[5]);
   assign line[5] = ~(line[4] | line2);

   assign Q[0] = line[4];
   assign QN[0] = line[5];

   if (WIRE > 1)
     serial_Dflipflop_rst #(.WIRE(WIRE-1)) recall(.D(D[WIRE-1:1]),
						  .clk(clk),
						  .rst(rst),
						  .Q(Q[WIRE-1:1]),
						  .QN(QN[WIRE-1:1]));
endmodule

`endif
