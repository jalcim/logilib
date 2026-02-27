module black(P, G, Pi, Pj, Gi, Gj);
   output P,  G;
   input  Pi, Pj, Gi, Gj;

   assign P = Pi & Pj;
   assign G = Gi | (Pi & Gj);

endmodule

module grey(P, G, A, B);
   output P,  G;
   input  A, B;

   assign P = A ^ B;
   assign G = A & B;

endmodule

module green(C_out, Pi, Gi, C_in);
  output C_out;
  input Pi, Gi, C_in;

  assign C_out = Gi | (Pi & C_in);

endmodule

module stage_0(P, G, A, B);
   output [7:0] P, G;
   input [7:0]	A, B;

   grey grey_0(P[0], G[0], A[0], B[0]);
   grey grey_1(P[1], G[1], A[1], B[1]);
   grey grey_2(P[2], G[2], A[2], B[2]);
   grey grey_3(P[3], G[3], A[3], B[3]);
   grey grey_4(P[4], G[4], A[4], B[4]);
   grey grey_5(P[5], G[5], A[5], B[5]);
   grey grey_6(P[6], G[6], A[6], B[6]);
   grey grey_7(P[7], G[7], A[7], B[7]);

endmodule

module brent_kung_cin (out, A, B, Cin);
   output [8:0] out;
   input	Cin;
   input [7:0]	A, B;

   wire [7:0]	black_P, black_G;
   wire [8:0]	C;

   wire	[7:0]	GREY_P, GREY_G;
   stage_0 stage_0_0(GREY_P, GREY_G, B, A);
   assign C[0] = Cin;

   //stage 1
   green green_1(C[1], GREY_P[0], GREY_G[0], C[0]);//0

//   wire [3:0] stage_1_P, stage_1_G;
   black black_0(black_P[0], black_G[0], GREY_P[1], GREY_P[0], GREY_G[1], GREY_G[0]);//1
   black black_1(black_P[1], black_G[1], GREY_P[3], GREY_P[2], GREY_G[3], GREY_G[2]);//3
   black black_2(black_P[2], black_G[2], GREY_P[5], GREY_P[4], GREY_G[5], GREY_G[4]);//5
   black black_3(black_P[3], black_G[3], GREY_P[7], GREY_P[6], GREY_G[7], GREY_G[6]);//7

   //stage 2
   green green_2(C[2], black_P[0], black_G[0], C[0]);//1

//   wire [3:0] stage_2_P, stage_2_G;
   black black_4(black_P[4], black_G[4], black_P[1], black_P[0], black_G[1], black_G[0]);//3
   black black_5(black_P[5], black_G[5], black_P[3], black_P[2], black_G[3], black_G[2]);//7

   //stage 3
   green green_3(C[3], GREY_P[2], GREY_G[2], C[2]);//2
   green green_4(C[4], black_P[4], black_G[4], C[0]);//3

//   wire [3:0] stage_3_P, stage_3_G;
   black black_6(black_P[6], black_G[6], black_P[5], black_P[4], black_G[5], black_G[4]);//7

   //stage 4
   green green_5(C[5], GREY_P[4], GREY_G[4], C[4]);//4
   green green_6(C[6], black_P[2], black_G[2], C[4]);//5

   //stage 5
   green green_7(C[7], GREY_P[6], GREY_G[6], C[6]);//6
   green green_8(C[8], black_P[6], black_G[6], C[6]);//7

   assign out[0] = GREY_P[0] ^ C[0];
   assign out[1] = GREY_P[1] ^ C[1];
   assign out[2] = GREY_P[2] ^ C[2];
   assign out[3] = GREY_P[3] ^ C[3];
   assign out[4] = GREY_P[4] ^ C[4];
   assign out[5] = GREY_P[5] ^ C[5];
   assign out[6] = GREY_P[6] ^ C[6];
   assign out[7] = GREY_P[7] ^ C[7];
   assign out[8] = C[8];

endmodule

module test;
   reg [7:0] A, B;
   reg	     C;
   wire [8:0] out, out2;

   brent_kung_cin test_bk(out, A, B, C);

   assign out2 = A+B+C;
   initial
     begin
	A = 0;
	B = 0;
	C = 0;
	#100;
	A = 8'b00000001;
	B = 8'b11111111;
	C = 0;
	#100;
	if (out != out2)
	  begin
	     $display("normal = %b\n", out2);
	     $display("out = %b\n", out);
	  end
	#100;
	A = 8'b00000000;
	B = 8'b11111111;
	C = 1;
	#100;
	if (out != out2)
	  begin
	     $display("normal = %b\n", out2);
	     $display("out = %b\n", out);
	  end
	#100;
	A = 8'b10101010;
	B = 8'b01010101;
	C = 0;
	#100;
	if (out != out2)
	  begin
	     $display("normal = %b\n", out2);
	     $display("out = %b\n", out);
	  end
	#100;
	A = 8'b10101010;
	B = 8'b01010101;
	C = 1;
	#100;
	if (out != out2)
	  begin
	     $display("normal = %b\n", out2);
	     $display("out = %b\n", out);
	  end
	#100;
     end

endmodule

/*
    //stage 1
   green green_1(C[1], GREY_P[0], GREY_G[0], C[0]);

   black black_1(black_P[0], black_G[0], GREY_P[7], GREY_P[6], GREY_G[7], GREY_G[6]);//7
   black black_2(black_P[1], black_G[1], GREY_P[5], GREY_P[4], GREY_G[5], GREY_G[4]);//5
   black black_3(black_P[2], black_G[2], GREY_P[3], GREY_P[2], GREY_G[3], GREY_G[2]);//3
   black black_4(black_P[3], black_G[3], GREY_P[1], GREY_P[0], GREY_G[1], GREY_G[0]);//1

   //stage 2
   green green_2(C[2], black_P[3], black_4G[3], C[0]);

   black black_5(black_P[4], black_G[4], black_P[0], black_P[1], black_G[0], black_G[1]);//7
   black black_6(black_P[5], black_G[5], black_P[2], black_P[3], black_G[2], black_G[3]);//3

   //stage 3
   green green_3(C[3], GREY_P[2], GREY_G[2], C[2]);
   green green_4(C[4], black_P[5], black_G[5], C[0]);

   black black_7(black_P[6], black_G[6], black_P[4], black_P[5], black_G[4], black_G[5]);//7

   //stage 4
   green green_5(C[5], GREY_P[4], GREY_G[4], C[4]);
   green green_6(C[6], black_P[1], black_G[1], C[4]);

   //stage 5
   green green_7(C[7], GREY_P[6], GREY_G[6], C[6]);
   green green_8(C[8], black_P[6], black_G[6], C[6]);
 */
