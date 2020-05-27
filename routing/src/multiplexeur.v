module multiplexeur_1bitx4(s0, a, b, c, d, s);
   input [1:0] s0;
   input       a, b, c, d;
   output      s;

   wire [3:0]  line;
   wire [3:0]  line2; 

   gate_not not1(s0[0], line[0]);
   gate_not not2(s0[1], line[1]);
   buf buf1(line[2], s0[0]);
   buf buf2(line[3], s0[1]);

   gate_and3 and1(line[1], line[0], a, line2[0]);
   gate_and3 and2(line[1], line[2], b, line2[1]);
   gate_and3 and3(line[3], line[0], c, line2[2]);
   gate_and3 and4(line[3], line[2], d, line2[3]);

   gate_or4 or1(line2[0], line2[1], line2[2], line2[3], s);
endmodule // multiplexeur_1bitx4

module multiplexeur_8bitx2(s0, a,b, s);
   input s0;
   input [7:0] a,b;
   output[7:0] s;

   wire        line1;
   wire [1:0]  line2;
   wire [7:0]  line3, line4, line5, line6;
   wire        masse;

   assign masse = 0;

   gate_not not0(s0, line1);
   gate_nor nor0(masse, s0, line2[0]);
   gate_nor nor1(masse, line1, line2[1]);
   
   buf buf0(line3[0], line2[0]);   buf buf1(line3[1], line2[0]);
   buf buf2(line3[2], line2[0]);   buf buf3(line3[3], line2[0]);
   buf buf4(line3[4], line2[0]);   buf buf5(line3[5], line2[0]);
   buf buf6(line3[6], line2[0]);   buf buf7(line3[7], line2[0]);

   buf buf10(line4[0], line2[1]);  buf buf11(line4[1], line2[1]);
   buf buf12(line4[2], line2[1]);  buf buf13(line4[3], line2[1]);
   buf buf14(line4[4], line2[1]);  buf buf15(line4[5], line2[1]);
   buf buf16(line4[6], line2[1]);  buf buf17(line4[7], line2[1]);

   gate_and8 and0(line3, a, line5);
   gate_and8 and1(line4, b , line6);
   gate_or8 or0(line5, line6, s);
endmodule // multiplexeur
/*
module multiplexeur_1bitx16(s0, a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p, z);
   input [3:0] s0;
   input       a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p;
   output      z;

   wire [7:0]  line1;
   wire [15:0] line2;

   buf buf1(line1[0], s0[0]);
   buf buf2(line1[1], s0[1]);
   buf buf3(line1[2], s0[2]);
   buf buf4(line1[3], s0[3]);

   not(s0[0], line1[4]);
   not(s0[1], line1[5]);
   not(s0[2], line1[6]);
   not(s0[3], line1[7]);

   and5 and1(line1[5], line1[6], line1[7], line1[8], a, line2[0]);
   and5 and2(line1[0], line1[6], line1[7], line1[8], b, line2[1]);
   and5 and3(line1[5], line1[1], line1[7], line1[8], c, line2[2]);
   and5 and4(line1[0], line1[1], line1[7], line1[8], d, line2[3]);
   and5 and5(line1[5], line1[6], line1[2], line1[8], e, line2[4]);
   and5 and6(line1[0], line1[6], line1[2], line1[8], f, line2[5]);
   and5 and7(line1[5], line1[1], line1[2], line1[8], g, line2[6]);
   and5 and8(line1[0], line1[1], line1[2], line1[8], h, line2[7]);
   and5 and9(line1[5], line1[6], line1[7], line1[3], i, line2[8]);
   and5 and10(line1[0], line1[6], line1[7], line1[3], j, line2[9]);
   and5 and11(line1[5], line1[1], line1[7], line1[3], k, line2[10]);
   and5 and12(line1[0], line1[1], line1[7], line1[3], l, line2[11]);
   and5 and13(line1[5], line1[6], line1[2], line1[3], m, line2[12]);
   and5 and14(line1[0], line1[6], line1[2], line1[3], n, line2[13]);
   and5 and15(line1[5], line1[1], line1[2], line1[3], o, line2[14]);
   and5 and16(line1[0], line1[1], line1[2], line1[3], p, line2[15]);

   or16 or1(line2, z);
endmodule; // multiplexeur

module multiplexeur_8bitx16(s0, a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p, z);
   input [3:0] s0;
   input [7:0] a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p;
   output[7:0] z;

   wire [7:0]  line1;
   wire [15:0] line2;
   wire [15:0] result0, result1, result2, result3, result4, result5, result6, result7,
	       result8, result9, result10, result11, result12, result13, result14, result15;
   wire [8:0] bus0, bus1, bus2, bus3, bus4, bus5, bus6, bus7,
	      bus8, bus9, bus10, bus11, bus12, bus13, bus14, bus15;

   assign line1[0] = s0[0];
   assign line1[1] = s0[1];
   assign line1[2] = s0[2];
   assign line1[3] = s0[3];

   not(s0[0], line1[4]);
   not(s0[1], line1[5]);
   not(s0[2], line1[6]);
   not(s0[3], line1[7]);

   and4 and1(line1[5], line1[6], line1[7], line1[8], line2[0]);
   and4 and2(line1[0], line1[6], line1[7], line1[8], line2[1]);
   and4 and3(line1[5], line1[1], line1[7], line1[8], line2[2]);
   and4 and4(line1[0], line1[1], line1[7], line1[8], line2[3]);
   and4 and5(line1[5], line1[6], line1[2], line1[8], line2[4]);
   and4 and6(line1[0], line1[6], line1[2], line1[8], line2[5]);
   and4 and7(line1[5], line1[1], line1[2], line1[8], line2[6]);
   and4 and8(line1[0], line1[1], line1[2], line1[8], line2[7]);
   and4 and9(line1[5], line1[6], line1[7], line1[3], line2[8]);
   and4 and10(line1[0], line1[6], line1[7], line1[3], line2[9]);
   and4 and11(line1[5], line1[1], line1[7], line1[3], line2[10]);
   and4 and12(line1[0], line1[1], line1[7], line1[3], line2[11]);
   and4 and13(line1[5], line1[6], line1[2], line1[3], line2[12]);
   and4 and14(line1[0], line1[6], line1[2], line1[3], line2[13]);
   and4 and15(line1[5], line1[1], line1[2], line1[3], line2[14]);
   and4 and16(line1[0], line1[1], line1[2], line1[3], line2[15]);

   assign bus0[0] = line2[0];assign bus0[1] = line2[0];assign bus0[2] = line2[0];assign bus0[3] = line2[0];
   assign bus0[4] = line2[0];assign bus0[5] = line2[0];assign bus0[6] = line2[0];assign bus0[7] = line2[0];
   assign bus1[0] = line2[1];assign bus1[1] = line2[1];assign bus1[2] = line2[1];assign bus1[3] = line2[1];
   assign bus1[4] = line2[1];assign bus1[5] = line2[1];assign bus1[6] = line2[1];assign bus1[7] = line2[1];
   assign bus2[0] = line2[2];assign bus2[1] = line2[2];assign bus2[2] = line2[2];assign bus2[3] = line2[2];
   assign bus2[4] = line2[2];assign bus2[5] = line2[2];assign bus2[6] = line2[2];assign bus2[7] = line2[2];
   assign bus3[0] = line2[3];assign bus3[1] = line2[3];assign bus3[2] = line2[3];assign bus3[3] = line2[3];
   assign bus3[4] = line2[3];assign bus3[5] = line2[3];assign bus3[6] = line2[3];assign bus3[7] = line2[3];
   assign bus4[0] = line2[4];assign bus4[1] = line2[4];assign bus4[2] = line2[4];assign bus4[3] = line2[4];
   assign bus4[4] = line2[4];assign bus4[5] = line2[4];assign bus4[6] = line2[4];assign bus4[7] = line2[4];
   assign bus5[0] = line2[5];assign bus5[1] = line2[5];assign bus5[2] = line2[5];assign bus5[3] = line2[5];
   assign bus5[4] = line2[5];assign bus5[5] = line2[5];assign bus5[6] = line2[5];assign bus5[7] = line2[5];
   assign bus6[0] = line2[6];assign bus6[1] = line2[6];assign bus6[2] = line2[6];assign bus6[3] = line2[6];
   assign bus6[4] = line2[6];assign bus6[5] = line2[6];assign bus6[6] = line2[6];assign bus6[7] = line2[6];
   assign bus7[0] = line2[7];assign bus7[1] = line2[7];assign bus7[2] = line2[7];assign bus7[3] = line2[7];
   assign bus7[4] = line2[7];assign bus7[5] = line2[7];assign bus7[6] = line2[7];assign bus7[7] = line2[7];
   assign bus8[0] = line2[8];assign bus8[1] = line2[8];assign bus8[2] = line2[8];assign bus8[3] = line2[8];
   assign bus8[4] = line2[8];assign bus8[5] = line2[8];assign bus8[6] = line2[8];assign bus8[7] = line2[8];
   assign bus9[0] = line2[9];assign bus9[1] = line2[9];assign bus9[2] = line2[9];assign bus9[3] = line2[9];
   assign bus9[4] = line2[9];assign bus9[5] = line2[9];assign bus9[6] = line2[9];assign bus9[7] = line2[9];
   assign bus10[0] = line2[10];assign bus10[1] = line2[10];assign bus10[2] = line2[10];assign bus10[3] = line2[10];
   assign bus10[4] = line2[10];assign bus10[5] = line2[10];assign bus10[6] = line2[10];assign bus10[7] = line2[10];
   assign bus11[0] = line2[11];assign bus11[1] = line2[11];assign bus11[2] = line2[11];assign bus11[3] = line2[11];
   assign bus11[4] = line2[11];assign bus11[5] = line2[11];assign bus11[6] = line2[11];assign bus11[7] = line2[11];
   assign bus12[0] = line2[12];assign bus12[1] = line2[12];assign bus12[2] = line2[12];assign bus12[3] = line2[12];
   assign bus12[4] = line2[12];assign bus12[5] = line2[12];assign bus12[6] = line2[12];assign bus12[7] = line2[12];
   assign bus13[0] = line2[13];assign bus13[1] = line2[13];assign bus13[2] = line2[13];assign bus13[3] = line2[13];
   assign bus13[4] = line2[13];assign bus13[5] = line2[13];assign bus13[6] = line2[13];assign bus13[7] = line2[13];
   assign bus14[0] = line2[14];assign bus14[1] = line2[14];assign bus14[2] = line2[14];assign bus14[3] = line2[14];
   assign bus14[4] = line2[14];assign bus14[5] = line2[14];assign bus14[6] = line2[14];assign bus14[7] = line2[14];
   assign bus15[0] = line2[15];assign bus15[1] = line2[15];assign bus15[2] = line2[15];assign bus15[3] = line2[15];
   assign bus15[4] = line2[15];assign bus15[5] = line2[15];assign bus15[6] = line2[15];assign bus15[7] = line2[15];

   and8 and80(bus0, a, result0);
   and8 and81(bus1, b, result1);
   and8 and82(bus2, c, result2);
   and8 and83(bus3, d, result3);
   and8 and84(bus4, e, result4);
   and8 and85(bus5, f, result5);
   and8 and86(bus6, g, result6);
   and8 and87(bus7, h, result7);
   and8 and88(bus8, i, result8);
   and8 and89(bus9, j, result9);
   and8 and810(bus10, k, result10);
   and8 and811(bus11, l, result11);
   and8 and812(bus12, m, result12);
   and8 and813(bus13, n, result13);
   and8 and814(bus14, o, result14);
   and8 and815(bus15, p, result15);

   or16 or1(line2, z);
endmodule; // multiplexeur
*/
