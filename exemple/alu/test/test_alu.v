module test_alu;
   parameter S = 4;
   parameter T1 = 8;
   parameter T2 = 1;
   
   reg clk;
   reg [3:0] op;
   reg [7:0] in1, in2;
   wire [7:0] out;

   integer    cpt;

   alu #(.S(S), .T1(T1), .T2(T2)) alu0(clk, op, in1, in2, out);

   initial
     begin
	$dumpfile("build/alu/alu/signal/signal_alu.vcd");
	$dumpvars;
	$display("\t\ttime, \top, \tin1, \tin2, \tout");
	$monitor("%d \t%d \t%d \t%d \t%d", $time, op, in1, in2, out);

	in1 = 5;
	in2 = 5;
	clk = 0;

	op = 0;
	#5;
	op = 1;
	#5;
	op = 5;
	#5;
	op = 7;
	#5;
	op = 8;
	#5;
//	op = 9;
	#5;
	op = 10;
	#5;
//	op = 11;
//	#5;
//	op = 12;
//	#5;
//	op = 13;
//	#5;
end // initial begin

endmodule // test_alu
