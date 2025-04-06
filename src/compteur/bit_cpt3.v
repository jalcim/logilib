`ifndef __BIT_CPT__
 `define __BIT_CPT__

`include "src/primitive/gate/gate_or.v"
`include "src/primitive/gate/gate_and.v"
`include "src/primitive/gate/gate_nor.v"
`include "src/primitive/gate/gate_not.v"

`include "src/memory/Dflipflop/Dflipflop_rst.v"

module bit_cpt3(activate, clk, reset, cpt);
   input activate, clk, reset;
   output [2:0] cpt;
/*

   wire [7:0] 	line;
   wire [2:0] 	ignore;

   gate_or or1(line[4], line[7], line[0]);
   gate_and and1(activate, line[0], line[1]);
   Dflipflop_rst flip1(line[1], clk, reset, line[2], ignore[0]);
   Dflipflop_rst flip2(line[2], clk, reset, line[3], ignore[1]);
   Dflipflop_rst flip3(line[3], clk, reset, line[4], ignore[2]);
   gate_nor nor1(line[2], line[3], line[5]);
   gate_not not1(line[4], line[6]);
   gate_and and2(line[5], line[6], line[7]);

   buf buf1(cpt[0], line[2]);
   buf buf2(cpt[1], line[3]);
   buf buf3(cpt[2], line[4]);
*/
endmodule // bit_cpt3

`endif
