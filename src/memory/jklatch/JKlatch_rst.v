`ifndef __JKLATCHUP_RST__
 `define __JKLATCHUP_RST__

module JKlatchUP_rst (j, k, clk, reset, out1, out2);
   input j, k, clk, reset;
   output out1, out2;

   wire [7:0] line;
   wire       unclock;
   wire [1:0] line_reset;

   or or_reset0(line_reset[0], reset, line[5]);
   or or_reset1(line_reset[1], reset, line[7]);

   not not0(unclock, clk);
   assign line[0] = ~(j & line_reset[1] & unclock);
   nor nor0(line[1], line_reset[0], line[0]);
   nand nand1(line[2], clk, line[1]);
   nand nand2(line[3], line_reset[1], line[2]);
   buf buf0(out1, line[3]);

   assign line[4] = ~(k & line[3] & unclock);
   nor nor1(line[5], line[1], line[4]);
   nand nand4(line[6], clk, line[5]);
   nand nand5(line[7], line[3], line[6]);
   buf buf1(out2, line[7]);

endmodule // JKlatchUP

`endif

`ifndef __JKLATCHDOWN_RST__
 `define __JKLATCHDOWN_RST__

module JKlatchDown_rst(j, k, clk, reset, out1, out2);
   input j, k, clk, reset;
   output out1, out2;

   wire [7:0] line;
   wire       unclock;
   wire [1:0] line_reset;

   or or_reset0(line_reset[0], line[5], reset);
   or or_reset1(line_reset[1], line[7], reset);
   not not0(clk, unclock);

   assign line[0] = ~(j & line_reset[1] & clk);
   nand nand_down0(line[1], line_reset[0], line[0]);
   nand nand1(line[2], unclock, line[1]);
   nand nand2(line[3], line_reset[1], line[2]);
   buf buf0(out1, line[3]);

   assign line[4] = k & line[3] & clk;
   nand nand_down1(line[5], line[1], line[4]);
   nand nand4(line[6], unclock, line[5]);
   nand nand5(line[7], line[4], line[6]);
   buf buf1(out2, line[7]);
   
   
endmodule // JKlatchDown

`endif
