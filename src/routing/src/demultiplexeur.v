//deprecated module

module demultiplexeur_1x8(s0, in, a,b,c,d,e,f,g,h);
   input [2:0] s0;
   input       in;
   output       a,b,c,d,e,f,g,h;

   wire [5:0]  line1;

   buf buf1(line1[0], s0[0]);
   buf buf2(line1[1], s0[1]);
   buf buf3(line1[2], s0[2]);

   gate_not not0(s0[0], line1[3]);
   gate_not not1(s0[1], line1[4]);
   gate_not not2(s0[2], line1[5]);

   gate_and4 and1(line1[3], line1[4], line1[5], in, a);
   gate_and4 and2(line1[3], line1[4], line1[2], in, b);
   gate_and4 and3(line1[3], line1[1], line1[5], in, c);
   gate_and4 and4(line1[3], line1[1], line1[2], in, d);
   gate_and4 and5(line1[0], line1[4], line1[5], in, e);
   gate_and4 and6(line1[0], line1[4], line1[2], in, f);
   gate_and4 and7(line1[0], line1[1], line1[5], in, g);
   gate_and4 and8(line1[0], line1[1], line1[2], in, h);

endmodule // demultiplexeur_1x8
