module Dflipflop(set, data, clk, reset, s1, s2);
   input set, data, clk;
   output s1, s2;

   wire [19:0] line;

   multi_nand #(.SIZE(3)) inst0(line[0], {set, line[3], line[1]});
   multi_nand #(.SIZE(3)) inst1(line[1], {line[0], clk, reset});
   multi_nand #(.SIZE(3)) inst2(line[2], {line[1], clk, line[3]});
   multi_nand #(.SIZE(3)) inst3(line[3], {line[2], data, reset});
   multi_nand #(.SIZE(3)) inst4(line[4], {set, line[1], line[5]});
   multi_nand #(.SIZE(3)) inst5(line[5], {line[4], line[2], reset});
endmodule
  
