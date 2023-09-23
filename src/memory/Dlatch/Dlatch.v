`ifndef __DLATCH__
 `define __DLATCH__

module Dlatch (D, clk, Q, QN);
   input D, clk;
   output Q, QN;

   wire [4:0] line;

   not not0(line[0], D);
   
   and and0(line[1], line[0], clk);
   and and1(line[2], D      , clk);

   nor nor0(line[3], line[1], line[4]);
   nor nor1(line[4], line[2], line[3]);

   assign Q  = line[3];
   assign QN = line[4];

endmodule

`endif
