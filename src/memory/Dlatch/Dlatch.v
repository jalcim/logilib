`ifndef __DLATCH__
 `define __DLATCH__

 `include "src/memory/Dlatch/parallel_Dlatch.v"
 `include "src/memory/Dlatch/serial_Dlatch.v"

module Dlatch (D, clk, Q, QN);
   parameter WAY = 1;
   parameter WIRE = 1;

   input [WAY -1: 0] clk;
   input [(WAY * WIRE)-1 : 0] D;
   output [(WAY * WIRE)-1:0]  Q, QN;

   wire [4:0] line;

   if (WAY > 1)
        parallel_Dlatch #(.WAY(WAY), .WIRE(WIRE)) parallel_Dlatch_inst(D, clk, Q, QN);
   else if (WIRE > 1)
        serial_Dlatch #(.WIRE(WIRE)) inst0(a, clk, s1, s2);
   else
     begin
	not not0(line[0], D);
   
	and and0(line[1], line[0], clk);
	and and1(line[2], D      , clk);

	nor nor0(line[3], line[1], line[4]);
	nor nor1(line[4], line[2], line[3]);

	assign Q  = line[3];
	assign QN = line[4];
     end

endmodule

`endif
