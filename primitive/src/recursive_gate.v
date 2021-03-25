module recursive_buf(in, out);
   parameter S = 1;

   input [2**S -1 : 0] in;
   output [2**S -1 : 0] out;

   if (S == 0)
     begin
	gate_buf buf2(in[0], out[0]);
     end
   else if (S == 1)
     begin
	gate_buf buf0(in[0], out[0]);
	gate_buf buf1(in[1], out[1]);
     end
   else
     begin
	recursive_buf #(.S(S-1))recursive_buf0(in[2**(S-1) -1: 0],
					       out[2**(S-1) -1: 0]);
	recursive_buf #(.S(S-1))recursive_buf1(in[2**S - 1:2**(S-1)],
					       out[2**S - 1:2**(S-1)]);
     end
endmodule // recursive_buf

module recursive_not(in, out);
   parameter S = 1;

   input [2**S -1 : 0] in;
   output [2**S -1 : 0] out;
   
   if (S == 1)
     begin
	gate_not not0(in[0], out[0]);
	gate_not not1(in[1], out[1]);
     end
   else
     begin
	recursive_not #(.S(S-1))recursive_not0(in[2**(S-1) -1: 0],
					       out[2**(S-1) -1: 0]);
	recursive_not #(.S(S-1))recursive_not1(in[2**S - 1:2**(S-1)],
					       out[2**S - 1:2**(S-1)]);
     end
endmodule // recursive_not

module recursive_and(in1, in2, out);
   parameter S = 1;

   input [2**S -1 : 0] in1, in2;
   output [2**S -1 : 0] out;
   
   if (S == 1)
     begin
	gate_and and0(in1[0], in2[0], out[0]);
	gate_and and1(in1[1], in2[1], out[1]);
     end
   else
     begin
	recursive_and #(.S(S-1))recursive_and0(in1[2**(S-1) -1: 0],
					       in2[2**(S-1) -1: 0],
					       out[2**(S-1) -1: 0]);
	recursive_and #(.S(S-1))recursive_and1(in1[2**S - 1:2**(S-1)],
					       in2[2**S - 1:2**(S-1)],
					       out[2**S - 1:2**(S-1)]);
     end
endmodule // recursive_and

module recursive_or(in1, in2, out);
   parameter S = 1;

   input [2**S -1 : 0] in1, in2;
   output [2**S -1 : 0] out;
   
   if (S == 1)
     begin
	gate_or or0(in1[0], in2[0], out[0]);
	gate_or or1(in1[1], in2[1], out[1]);
     end
   else
     begin
	recursive_or #(.S(S-1))recursive_or0(in1[2**(S-1) -1: 0],
					       in2[2**(S-1) -1: 0],
					       out[2**(S-1) -1: 0]);
	recursive_or #(.S(S-1))recursive_or1(in1[2**S - 1:2**(S-1)],
					       in2[2**S - 1:2**(S-1)],
					       out[2**S - 1:2**(S-1)]);
     end
endmodule // recursive_or

module recursive_xor(in1, in2, out);
   parameter S = 1;

   input [2**S -1 : 0] in1, in2;
   output [2**S -1 : 0] out;
   
   if (S == 1)
     begin
	gate_xor xor0(in1[0], in2[0], out[0]);
	gate_xor xor1(in1[1], in2[1], out[1]);
     end
   else
     begin
	recursive_xor #(.S(S-1))recursive_xor0(in1[2**(S-1) -1: 0],
					       in2[2**(S-1) -1: 0],
					       out[2**(S-1) -1: 0]);
	recursive_xor #(.S(S-1))recursive_xor1(in1[2**S - 1:2**(S-1)],
					       in2[2**S - 1:2**(S-1)],
					       out[2**S - 1:2**(S-1)]);
     end
endmodule // recursive_xor

module recursive_xnor(in1, in2, out);
   parameter S = 1;

   input [2**S -1 : 0] in1, in2;
   output [2**S -1 : 0] out;
   
   if (S == 1)
     begin
	gate_xnor xnor0(in1[0], in2[0], out[0]);
	gate_xnor xnor1(in1[1], in2[1], out[1]);
     end
   else
     begin
	recursive_xnor #(.S(S-1))recursive_xnor0(in1[2**(S-1) -1: 0],
					       in2[2**(S-1) -1: 0],
					       out[2**(S-1) -1: 0]);
	recursive_xnor #(.S(S-1))recursive_xnor1(in1[2**S - 1:2**(S-1)],
					       in2[2**S - 1:2**(S-1)],
					       out[2**S - 1:2**(S-1)]);
     end
endmodule // recursive_xnor

module recursive_nand(in1, in2, out);
   parameter S = 1;

   input [2**S -1 : 0] in1, in2;
   output [2**S -1 : 0] out;
   
   if (S == 1)
     begin
	gate_nand nand0(in1[0], in2[0], out[0]);
	gate_nand nand1(in1[1], in2[1], out[1]);
     end
   else
     begin
	recursive_nand #(.S(S-1))recursive_nand0(in1[2**(S-1) -1: 0],
					       in2[2**(S-1) -1: 0],
					       out[2**(S-1) -1: 0]);
	recursive_nand #(.S(S-1))recursive_nand1(in1[2**S - 1:2**(S-1)],
					       in2[2**S - 1:2**(S-1)],
					       out[2**S - 1:2**(S-1)]);
     end
endmodule // recursive_nand

module recursive_nor(in1, in2, out);
   parameter S = 1;

   input [2**S -1 : 0] in1, in2;
   output [2**S -1 : 0] out;
   
   if (S == 1)
     begin
	gate_nor nor0(in1[0], in2[0], out[0]);
	gate_nor nor1(in1[1], in2[1], out[1]);
     end
   else
     begin
	recursive_nor #(.S(S-1))recursive_nor0(in1[2**(S-1) -1: 0],
					       in2[2**(S-1) -1: 0],
					       out[2**(S-1) -1: 0]);
	recursive_nor #(.S(S-1))recursive_nor1(in1[2**S - 1:2**(S-1)],
					       in2[2**S - 1:2**(S-1)],
					       out[2**S - 1:2**(S-1)]);
     end
endmodule // recursive_nor


