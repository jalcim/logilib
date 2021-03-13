module test_multi_Dlatch;
   parameter S = 3;

   reg [7:0] in;
   reg 	     clk, reset;
   wire [7:0] out1, out2;

   multi_Dlatch #(.S(S)) multi_Dlatch0(in, clk, reset, out1, out2);

   initial
     begin
	$dumpfile("build/memory/signal/signal_multi_Dlatch.vcd");
	$dumpvars;
	$display("\t\ttime \t\tin, \tout1, \tout2");
	$monitor("%d\t\t%d\t%d\t%d", $time, in, out1, out2);

	assign in = 125;
	clk = 0;
	reset = 1;
	#5;
	reset = 0;
	clk = 1;
	#5;

     end // initial begin
endmodule
	
