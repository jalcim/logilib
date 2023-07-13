module divmod2(activate, clk, reset, a, div2, mod2, endop);
   input activate, clk, reset;
   input [7:0] a;
   output      mod2;
   output [7:0] div2;
   output endop;
   
   wire [2:0] 	cpt;
   wire [1:0] 	cpt_line1;
   wire 	cpt_line2;
   wire [8:0] 	mux_line1;
   wire [8:0] 	d_line;
   wire [7:0] 	mux_line2;
   wire 	mux_line3;
   wire 	masse;
   wire [7:0] 	ignore;
   wire [8:0]	ignore1;
   wire 	ignore0;	
   
   bit_cpt3 compteur(activate, clk, reset, cpt);
   buf buf0(cpt_line1[0], cpt[0]);
   buf buf1(cpt_line1[1], cpt[1]);
   buf buf2(cpt_line2, cpt[2]);

   assign masse = 0;

   multiplexeur_1bitx4 mux0(cpt_line1, d_line[0], a[7], masse, masse, mux_line1[0]);
   multiplexeur_1bitx4 mux1(cpt_line1, d_line[1], a[6], d_line[0], masse, mux_line1[1]);
   multiplexeur_1bitx4 mux2(cpt_line1, d_line[2], a[5], d_line[1], masse, mux_line1[2]);
   multiplexeur_1bitx4 mux3(cpt_line1, d_line[3], a[4], d_line[2], masse, mux_line1[3]);
   multiplexeur_1bitx4 mux4(cpt_line1, d_line[4], a[3], d_line[3], masse, mux_line1[4]);
   multiplexeur_1bitx4 mux5(cpt_line1, d_line[5], a[2], d_line[4], masse, mux_line1[5]);
   multiplexeur_1bitx4 mux6(cpt_line1, d_line[6], a[1], d_line[5], masse, mux_line1[6]);
   multiplexeur_1bitx4 mux7(cpt_line1, d_line[7], a[0], d_line[6], masse, mux_line1[7]);
   multiplexeur_1bitx4 mux8(cpt_line1, d_line[8], masse, d_line[7], masse, mux_line1[8]);

   Dflip_flop flipflopD0(mux_line1[0], clk, reset, d_line[0], ignore1[0]);
   Dflip_flop flipflopD1(mux_line1[1], clk, reset, d_line[1], ignore1[1]);
   Dflip_flop flipflopD2(mux_line1[2], clk, reset, d_line[2], ignore1[2]);
   Dflip_flop flipflopD3(mux_line1[3], clk, reset, d_line[3], ignore1[3]);
   Dflip_flop flipflopD4(mux_line1[4], clk, reset, d_line[4], ignore1[4]);
   Dflip_flop flipflopD5(mux_line1[5], clk, reset, d_line[5], ignore1[5]);
   Dflip_flop flipflopD6(mux_line1[6], clk, reset, d_line[6], ignore1[6]);
   Dflip_flop flipflopD7(mux_line1[7], clk, reset, d_line[7], ignore1[7]);
   Dflip_flop flipflopD8(mux_line1[8], clk, reset, d_line[8], ignore1[8]);
   
   gate_and and0(cpt_line2, d_line[0], mux_line2[7]);
   gate_and and1(cpt_line2, d_line[1], mux_line2[6]);
   gate_and and2(cpt_line2, d_line[2], mux_line2[5]);
   gate_and and3(cpt_line2, d_line[3], mux_line2[4]);
   gate_and and4(cpt_line2, d_line[4], mux_line2[3]);
   gate_and and5(cpt_line2, d_line[5], mux_line2[2]);
   gate_and and6(cpt_line2, d_line[6], mux_line2[1]);
   gate_and and7(cpt_line2, d_line[7], mux_line2[0]);
   gate_and and8(cpt_line2, d_line[8], mux_line3);

   basculeD_8bit D_latch0(mux_line2, cpt_line2, reset, div2, ignore);
   basculeD Dlatch1(mux_line3, cpt_line2, reset, mod2, ignore0);
   buf buf3(endop, cpt_line2);
endmodule // divmod2
