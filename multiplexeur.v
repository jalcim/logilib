module multiplexeur(s0, a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p, z);
   input [3:0] s0;
   input       a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p;
   output      z;

   wire [7:0]  line1;
   wire [15:0] line2;

   assign line1[0] = s0[0];
   assign line1[1] = s0[1];
   assign line1[2] = s0[2];
   assign line1[3] = s0[3];

   not(s0[0], line1[4]);
   not(s0[1], line1[5]);
   not(s0[2], line1[6]);
   not(s0[3], line1[7]);

   and5 and1(line1[5], line1[6], line1[7], line1[8], a, line2[0]);
   and5 and1(line1[0], line1[6], line1[7], line1[8], b, line2[1]);
   and5 and1(line1[5], line1[1], line1[7], line1[8], c, line2[2]);
   and5 and1(line1[0], line1[1], line1[7], line1[8], d, line2[3]);
   and5 and1(line1[5], line1[6], line1[2], line1[8], e, line2[4]);
   and5 and1(line1[0], line1[6], line1[2], line1[8], f, line2[5]);
   and5 and1(line1[5], line1[1], line1[2], line1[8], g, line2[6]);
   and5 and1(line1[0], line1[1], line1[2], line1[8], h, line2[7]);
   and5 and1(line1[5], line1[6], line1[7], line1[3], i, line2[8]);
   and5 and1(line1[0], line1[6], line1[7], line1[3], j, line2[9]);
   and5 and1(line1[5], line1[1], line1[7], line1[3], k, line2[10]);
   and5 and1(line1[0], line1[1], line1[7], line1[3], l, line2[11]);
   and5 and1(line1[5], line1[6], line1[2], line1[3], m, line2[12]);
   and5 and1(line1[0], line1[6], line1[2], line1[3], n, line2[13]);
   and5 and1(line1[5], line1[1], line1[2], line1[3], o, line2[14]);
   and5 and1(line1[0], line1[1], line1[2], line1[3], p, line2[15]);

   or16 or1(line2, z);
endmodule; // multiplexeur
