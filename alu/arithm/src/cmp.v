module cmp(a, b, c, d);
   input a, b;
   output c, d;
   wire [1:0]  line;
   
   
   gate_not not1(a, line[0]);
   gate_not not2(b, line[1]);

   gate_and and1(line[0], b, c);
   gate_and and2(line[1], a, d);
endmodule // cmp

module cmp8(a, b, i, j, k);
   input [7:0] a,b;
   output      i, j, k;
   wire [15:0] line1;
   wire [7:0] line2;
   wire [14:0] line3;

   cmp cmp1(a[0], b[0], line1[0], line1[1]);
   cmp cmp2(a[1], b[1], line1[2], line1[3]);
   cmp cmp3(a[2], b[2], line1[4], line1[5]);
   cmp cmp4(a[3], b[3], line1[6], line1[7]);
   cmp cmp5(a[4], b[4], line1[8], line1[9]);
   cmp cmp6(a[5], b[5], line1[10], line1[11]);
   cmp cmp7(a[6], b[6], line1[12], line1[13]);
   cmp cmp8(a[7], b[7], line1[14], line1[15]);

   gate_nor nor1(line1[0], line1[1], line2[0]);
   gate_nor nor2(line1[2], line1[3], line2[1]);
   gate_nor nor3(line1[4], line1[5], line2[2]);
   gate_nor nor4(line1[6], line1[7], line2[3]);
   gate_nor nor5(line1[8], line1[9], line2[4]);
   gate_nor nor6(line1[10], line1[11], line2[5]);
   gate_nor nor7(line1[12], line1[13], line2[6]);
   gate_nor nor8(line1[14], line1[15], line2[7]);

   gate_and and1(line1[0], line2[1], line3[0]);
   gate_or or1(line3[0], line1[2], line3[1]);
   gate_and and2(line3[1], line2[2], line3[2]);
   gate_or or2(line3[2], line1[4], line3[3]);
   gate_and and3(line3[3], line2[3], line3[4]);
   gate_or or3(line3[4], line1[6], line3[5]);
   gate_and and4(line3[5], line2[4], line3[6]);
   gate_or or4(line3[6], line1[8], line3[7]);
   gate_and and5(line3[7], line2[5], line3[8]);
   gate_or or5(line3[8], line1[10], line3[9]);
   gate_and and6(line3[9], line2[6], line3[10]);
   gate_or or6(line3[10], line1[12], line3[11]);
   gate_and and7(line3[11], line2[7], line3[12]);
   gate_or or7(line3[12], line1[14], line3[13]);

   multigate_and8 and81(line2, line3[14]);
   gate_nor nor9(line3[13], line3[14], j);
   assign i = line3[14];
   assign k = line3[13];
endmodule // cmp8
