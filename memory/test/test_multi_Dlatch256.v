module test_multi_Dlatch;
   parameter S = 11;

   reg [2**S-1:0] in, clk;
   reg 	     reset;
   wire [2**S-1:0] out1, out2;

   multi_Dlatch #(.S(S)) multi_Dlatch0(in, clk, reset, out1, out2);

   initial
     begin
	$dumpfile("build/memory/signal/signal_multi_Dlatch256.vcd");
	$dumpvars;
	$display("\t\ttime \t\tin, \tout1, \tout2");
	$monitor("%d\n%b\n%b\n%b\n", $time, in[2**S-1:0], out1[2**S-1:0], out2[2**S-1:0]);

	assign in = 2**(2**S)-1;
	clk = 0;
	reset = 1;
	#5;
	reset = 0;
	clk = 2**(2**S)-1;
	#5;

     end // initial begin
endmodule
	
