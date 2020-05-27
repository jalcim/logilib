module mult(activate, clk, reset, a, b, c, div, mod);
   input activate, clk, reset, a;
   input [7:0] b, c;
   output [7:0] div;
   output 	mod;

   wire [7:0] 	line0, line1, line2;
   wire 	diffused_clk;
   wire [7:0] 	masse8, ignore;
   wire 	masse;
   
   assign masse = 0;
   assign masse8 = 0;

   multiplexeur_8bitx2 mux0(a, masse8, b, line0);
   add8 add0(line0, c, masse, masse, line1, z);
   gate_and and0(activate, clk, diffused_clk);
   basculeD_8bit Dlatch8bit_0(line1, diffused_clk, reset, line2, ignore);
   divmod2 divmod2_0(activate, clk, reset, line2, div, mod);
endmodule
