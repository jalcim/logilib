module mult(activate, clk, reset, a, b, c, div, mod, endop);
   input activate, clk, reset, a;
   input [7:0] b, c;
   output [7:0] div;
   output 	mod;
   output 	endop;

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
   divmod2 divmod2_0(activate, clk, reset, line2, div, mod, endop);
endmodule

module mult_8(activate, clk, reset, in1, in2, mult8, mult16);
   input activate, clk, reset;
   input [7:0] in1, in2;
   input [7:0] line1, line2, line3, line4, line5, line6, line7, line8;
   input [7:0] masse;

   output [7:0] mult8, mult16;

   wire [7:0] 	cpt_line;
   wire [2:0] 	cpt_line1;
   wire 	cpt_line2; 	

   wire 	mux_line1;
   wire 	unclock;
   wire 	sig_reset;
   wire 	and_reset;
   wire 	int_reset;
   supply1 	power;
   
   wire [7:0] 	line_ret;
   wire 	line_mod;
   wire [7:0] 	line_div; 	
   wire 	line_end;

   wire [2:0] 	addr;

   wire [7:0]	addr_clk, addr_data, bus_data;
   wire [7:0] 	ignore, ignore3, ignore4;
   wire [2:0] 	ignore2;
   
   basculeD_8bit Dlatch8_0(line_div, line_endop, int_reset, line_ret, ignore);
   mult mult(activate, clk, int_reset, mux_line1, in2, line_ret, line_div, line_mod, line_endop);
   gate_not not0(clk, unclock);
   cpt_bin8 cpt(activate, line_endop, int_reset, cpt_line);
   buf buf0(cpt_line1[0], cpt_line[0]);
   buf buf1(cpt_line1[1], cpt_line[1]);
   buf buf2(cpt_line1[2], cpt_line[2]);
   buf buf3(cpt_line2, cpt_line[3]);
   Dflip_flop DF_reset(cpt_line2, clk, reset, sig_reset, z);
   basculeD_8bit Dout_2(line_div, cpt_line2, reset, mult16, ignore4);
   multiplexeur_1x8 mux_1x8(cpt_line1, in1[0], in1[1], in1[2], in1[3], in1[4], in1[5], in1[6], in1[7], mux_line1);
   Dflip_flop3 demux_addr(cpt_line1, line_endop, reset, addr, ignore2);
   gate_and and0(unclock, sig_reset, and_reset);
   gate_or or0(and_reset, reset, int_reset);
   demultiplexeur_1x8 demux_addr_data(addr, line_mod, addr_data[0], addr_data[1], addr_data[2], addr_data[3],
				      addr_data[4], addr_data[5], addr_data[6], addr_data[7]);
   demultiplexeur_1x8 demux_addr_clk(addr, power, addr_clk[0], addr_clk[1], addr_clk[2], addr_clk[3],
				      addr_clk[4], addr_clk[5], addr_clk[6], addr_clk[7]);
   basculeD Data_0(addr_data[0], addr_clk[0], int_reset, bus_data[0], z);
   basculeD Data_1(addr_data[1], addr_clk[1], int_reset, bus_data[1], z);
   basculeD Data_2(addr_data[2], addr_clk[2], int_reset, bus_data[2], z);
   basculeD Data_3(addr_data[3], addr_clk[3], int_reset, bus_data[3], z);
   basculeD Data_4(addr_data[4], addr_clk[4], int_reset, bus_data[4], z);
   basculeD Data_5(addr_data[5], addr_clk[5], int_reset, bus_data[5], z);
   basculeD Data_6(addr_data[6], addr_clk[6], int_reset, bus_data[6], z);
   basculeD Data_7(addr_data[7], addr_clk[7], int_reset, bus_data[7], z);
   basculeD_8bit Dout_1(bus_data, cpt_line2, reset, mult8, ignore3);
   
endmodule // mult_8
