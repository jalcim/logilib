module test_cmp8;

   reg [7:0] a, b;
   wire      i, j, k;

   cmp8 test_cmp(a, b, i, j, k);

   initial
     begin
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
     end // initial begin
   initial
     begin
	$dumpfile("signal_cmp.vcd");
	$dumpvars;
     end
   initial
     begin
	$display("\t\ttime, \ta, \tb, \ti, \tj, \tk");
	$monitor("%d \t%d \t%d \t%b \t%b \t%b", $time, a, b, i, j, k);
     end
endmodule // test_cmp

	
