module test_cmp;

   reg a, b;
   wire c, d;

   cmp test_cmp(a, b, c, d);

   initial
     begin
	a = 0;
	b = 0;
	#5;
	a = 1;
	b = 0;
	#5;
	a = 0;
	b = 1;
	#5;
	a = 1;
	b = 1;
     end // initial begin
   initial
     begin
	$dumpfile("signal_cmp.vcd");
	$dumpvars;
     end
   initial
     begin
	$display("\ttime, \ta, \tb, \tc, \td");
	$monitor("%d \t%b \t%b \t%b \t%b", $time, a, b, c, d);
     end
endmodule // test_cmp

	
