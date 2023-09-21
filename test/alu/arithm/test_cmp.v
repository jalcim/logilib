`include "src/alu/arithm/cmp.v"

module test_cmp8;

   reg [7:0] a, b;
   wire      eq, less, more;

   cmp #(.WIRE(8)) test_cmp(a, b, eq, more, less);

   initial
     begin
	$dumpfile("signal_cmp.vcd");
	$dumpvars;
	$display("\t\ttime, \ta, \tb, \teq, \tmore, \tless\n");
	$monitor("%d \t%d \t%d \t%b \t%b \t%b", $time, a, b, eq, more, less);

	a = 0;
	b = 0;
	#5;
	a = 22;
	b = 12;
	#5;
	a = 12;
	b = 22;
	#5;
	a = 22;
	b = 22;
     end
endmodule

	
