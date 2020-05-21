module cmp(a, b, c, d);
   input a, b;
   output c, d;
   wire [1:0]  line;
   
   
   not not1(a, line[0]);
   not not2(b, line[1]);

   and and1(line[0], a, c);
   and and2(line[1], b, d);
endmodule; // cmp

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

   nor nor1(line1[0], line1[1], line2[0]);
   nor nor2(line1[2], line1[3], line2[1]);
   nor nor3(line1[4], line1[5], line2[2]);
   nor nor4(line1[6], line1[7], line2[3]);
   nor nor5(line1[8], line1[9], line2[4]);
   nor nor6(line1[10], line1[11], line2[5]);
   nor nor7(line1[12], line1[13], line2[6]);
   nor nor8(line1[14], line1[15], line2[7]);

   and and1(line1[0], line2[1], line3[0]);
   or or1(line3[0], line1[2], line3[1]);
   and and2(line3[1], line2[2], line3[2]);
   or or1(line3[2], line1[4], line3[3]);
   and and3(line3[3], line2[3], line3[4]);
   or or1(line3[4], line1[6], line3[5]);
   and and4(line3[5], line2[4], line3[6]);
   or or1(line3[6], line1[8], line3[7]);
   and and5(line3[7], line2[5], line3[8]);
   or or1(line3[8], line1[10], line3[9]);
   and and6(line3[9], line2[6], line3[10]);
   or or1(line3[10], line1[12], line3[11]);
   and and7(line3[11], line2[7], line3[12]);
   or or1(line3[12], line1[14], line3[13]);

   
   //and8(line2, i);
   nor(line3[13], line3[14], j);
   assign k = line3[13];
endmodule; // cmp8
