`ifndef __DLATCH_PRE__
 `define __DLATCH_PRE__

 `include "src/memory/Dlatch/parallel_Dlatch/parallel_Dlatch_pre.v"
 `include "src/memory/Dlatch/serial_Dlatch/serial_Dlatch_pre.v"

module Dlatch_pre(D, clk, preset, Q, QN);
   parameter WAY = 1;
   parameter WIRE = 1;

   input [WAY -1: 0] clk;
   input [WAY*WIRE-1 : 0] D, preset;;
   output [WAY*WIRE-1: 0]  Q, QN;

   wire [5:0]		      line;

   if (WAY > 1)
        parallel_Dlatch_pre #(.WAY(WAY), .WIRE(WIRE)) parallel_Dlatch_pre_inst(D, clk, preset, Q, QN);
   else if (WIRE > 1)
        serial_Dlatch_pre #(.WIRE(WIRE)) inst0(D, clk, preset, Q, !N);
   else
     begin
	not not0(line[0], clk);
	nor nor0(line[1], D, line[0]);
	nor nor1(line[2], line[1], line[5]);
	or  or2 (line[3], line[2], preset);

	and and3(line[4], clk, D);
	nor nor4(line[5], line[4], line[3]);

	assign Q = line[3];
	assign QN = line[5];
     end

endmodule

`endif
