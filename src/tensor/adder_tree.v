module adder_tree(input [SIZE - 1 : 0]	datain,
		  output [WIRE-1 : 0]	dataout);

   parameter WAY = 4;
   parameter WIRE = 32;
   localparam SIZE = WAY * WIRE;//288

   localparam  N1 = ((WAY / 2) + (WAY % 2));//5
   localparam  N2 = (WAY / 2);//4

   if (WAY == 1)
     assign dataout = datain;
   else if (WAY == 2)
     assign dataout = datain[63:WIRE] + datain[WIRE-1:0];
   else
     begin
	wire [WIRE-1:0] out1, out2;

	adder_tree #(.WAY(N1)) adder1(datain[SIZE - 1 : SIZE - N1*WIRE], out1);//287:128
	adder_tree #(.WAY(N2)) adder2(datain[N2*WIRE - 1 : 0], out2);//127:0

	assign dataout = out1 + out2;
     end

endmodule

/*
module test;
   parameter WIRE = 32;

   reg [WIRE-1:0] A, B, C, D, E, F, G, H, I;
   wire [WIRE-1:0] S;

   adder_tree #(.WAY(9), .WIRE(WIRE)) adder_tree({A, B, C, D, E, F, G, H, I}, S);

   initial
     begin
	A <= 32'd1;
	B <= 32'd2;
	C <= 32'd4;
	D <= 32'd8;
	E <= 32'd16;
	F <= 32'd32;
	G <= 32'd64;
	H <= 32'd128;
	I <= 32'd256;
	#100;

	$display("%d\n", S);
     end

endmodule
*/
