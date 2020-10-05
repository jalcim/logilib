module JKlatchUP (j, k, clk, reset, out1, out2);
   input j, k, clk, reset;
   output out1, out2;

   wire [7:0] line;
   wire       unclock;
   wire [1:0] line_reset;
   
   gate_or or_reset0(reset, line[5], line_reset[0]);
   gate_or or_reset1(reset, line[7], line_reset[1]);
   gate_not not0(clk, unclock);

   multigate_nand3 nand0(j, line_reset[1], unclock, line[0]);
   gate_nor nor0(line[0], line_reset[0], line[1]);
   gate_nand nand1(line[1], clk, line[2]);
   gate_nand nand2(line[2], line_reset[1], line[3]);
   buf buf0(out1, line[3]);

   multigate_nand3 nand3(k, line[3], unclock, line[4]);
   gate_nor nor1(line[4], line[1], line[5]);
   gate_nand nand4(line[5], clk, line[6]);
   gate_nand nand5(line[6], line[3], line[7]);
   buf buf1(out2, line[7]);

   initial
     begin
//	$display("\tline[2], \tline[3], \tline_reset");
//	$monitor("\t%b, \t%b, \t%b", line[2], line, line_reset[1]);
     end
   
endmodule // JKlatchUP

module JKlatchDown(j, k, clk, reset, out1, out2);
   input j, k, clk, reset;
   output out1, out2;

   wire [7:0] line;
   wire       unclock;
   wire [1:0] line_reset;

   gate_or or_reset0(reset, line[5], line_reset[0]);
   gate_or or_reset1(reset, line[7], line_reset[1]);
   gate_not not0(clk, unclock);

   multigate_nand3 nand0(j, line_reset[1], clk, line[0]);
   gate_nand nand_down0(line[0], line_reset[0], line[1]);
   gate_nand nand1(line[1], unclock, line[2]);
   gate_nand nand2(line[2], line_reset[1], line[3]);
   buf buf0(out1, line[3]);

   multigate_nand3 nand3(k, line[3], clk, line[4]);
   gate_nand nand_down1(line[4], line[1], line[5]);
   gate_nand nand4(line[5], unclock, line[6]);
   gate_nand nand5(line[6], line[4], line[7]);
   buf buf1(out2, line[7]);
   
   
endmodule // JKlatchDown
