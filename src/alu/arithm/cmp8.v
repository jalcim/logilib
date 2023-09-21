module cmp8(a, b, i, j, k);
   input [7:0] a,b;
   output      i, j, k;
   wire [15:0] line1;
   
   wire [7:0] out_nor;
   wire [14:0] line3;

   cmp cmp1(a[0], b[0], left[0], right[0]);
   cmp cmp2(a[1], b[1], left[1], right[1]);
   cmp cmp3(a[2], b[2], left[2], right[2]);
   cmp cmp4(a[3], b[3], left[3], right[3]);
   cmp cmp5(a[4], b[4], left[4], right[4]);
   cmp cmp6(a[5], b[5], left[5], right[5]);
   cmp cmp7(a[6], b[6], left[6], right[6]);
   cmp cmp8(a[7], b[7], left[7], right[7]);

   gate_nor nor1(left[0], right[0], out_nor[0]);
   gate_nor nor2(left[1], right[1], out_nor[1]);
   gate_nor nor3(left[2], right[2], out_nor[2]);
   gate_nor nor4(left[3], right[3], out_nor[3]);
   gate_nor nor5(left[4], right[4], out_nor[4]);
   gate_nor nor6(left[5], right[5], out_nor[5]);
   gate_nor nor7(left[6], right[6], out_nor[6]);
   gate_nor nor8(left[7], right[7], out_nor[7]);

   //////////////////////

   gate_and and1(left[0] , out_nor[1], line3[0]);
   gate_or or1(line3[0] , left[1] , line3[1]);

   gate_and and2(line3[1] , out_nor[2], line3[2]);
   gate_or or2(line3[2] , left[2] , line3[3]);

   gate_and and3(line3[3] , out_nor[3], line3[4]);
   gate_or or3(line3[4] , left[3] , line3[5]);

   gate_and and4(line3[5] , out_nor[4], line3[6]);
   gate_or or4(line3[6] , left[4] , line3[7]);

   gate_and and5(line3[7] , out_nor[5], line3[8]);
   gate_or or5(line3[8] , left[5], line3[9]);

   gate_and and6(line3[9] , out_nor[6], line3[10]);
   gate_or or6(line3[10], left[6], line3[11]);

   gate_and and7(line3[11], out_nor[7], line3[12]);
   gate_or or7(line3[12], left[7], line3[13]);

   ///////////////////////

   multigate_and8 and81(out_nor, line3[14]);
   gate_nor nor9(line3[13], line3[14], j);

   assign i = line3[14];
   assign k = line3[13];
endmodule // cmp8
