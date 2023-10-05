`ifndef __DFLIPFLOP_PRE__
 `define __DFLIPFLOP_PRE__

 `include "src/memory/Dflipflop/parallel_Dflipflop.v"
 `include "src/memory/Dflipflop/serial_Dflipflop.v"

module Dflipflop_pre(preset, D, clk, reset, Q, QN);
   parameter WAY = 1;
   parameter WIRE = 1;

   input [WAY-1:0] reset, clk;
   input [WAY*WIRE -1:0] D, preset;
   output [WAY-1:0]	 Q, QN;

   wire [5:0]		 line;

   if (WAY > 1)
        parallel_Dflipflop #(.WAY(WAY), .WIRE(WIRE)) parallel_Dflipflop_inst(D, clk, Q, QN);
   else if (WIRE > 1)
        serial_Dflipflop #(.WIRE(WIRE)) inst0(a, clk, s1, s2);
   else
     begin
	assign line[0] = ~(line[3] | line[2]);
	assign line[1] = ~(line[2] | clk | line[3]);
	assign line[2] = ~(line[0] | preset | clk);
	assign line[3] = ~(line[1] | D | preset);

	assign line[4] = ~(line[2] | line[5]);
	assign line[5] = ~(line[4] | line[1] | preset);

	assign Q = line[4];
	assign QN = line[5];
     end
endmodule

`endif
