`include "src/routing/encoder.v"

module test_encoder;
   reg [15:0] in;
   wire [3:0]  addr;

   encoder #(.SIZE_ADDR(4)) encoder0(addr, in);

   initial
     begin
	$dumpfile("signal_encoder.vcd");
	$dumpvars;
	$display("\t\ttime, \tin, \taddr");
	$monitor("%d \t%b \t%d", $time, in, addr);

	in <= 16'b1;
	#10;
	in <= 16'b10;
	#10;
	in <= 16'b100;
	#10;
	in <= 16'b1000;
	#10;
	in <= 16'b10000;
	#10;
	in <= 16'b100000;
	#10;
	in <= 16'b1000000;
	#10;
	in <= 16'b10000000;
	#10;
	in <= 16'b100000000;
	#10;
	in <= 16'b1000000000;
	#10;
	in <= 16'b10000000000;
	#10;
	in <= 16'b100000000000;
	#10;
	in <= 16'b1000000000000;
	#10;
	in <= 16'b10000000000000;
	#10;
	in <= 16'b100000000000000;
	#10;
	in <= 16'b1000000000000000;
	#10;
     end
endmodule
