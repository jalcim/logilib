module JKlatchUP (j, k, clk, reset, out1, out2);
   input j, k, clk, reset;
   output out1, out2;

   wire [x:0] line;
   wire       unclock;
   wire [1:0] line_reset;
   

   gate_or or_reset0(reset, x, line_reset[0]);
   gate_or or_reset1(reset, x, line_reset[0]);
   gate_not not0(clk, unclock);

   multigate_nand3 nand0(j, x, unclock, line[0]);
   gate_or or0(line[0], )
   
endmodule // JKlatchUP

module JKlatchDown(in1, in2, clk, reset, out1, out2);
   input in1, in2, clk, reset;
   output out1, out2;

endmodule // JKlatchDown
