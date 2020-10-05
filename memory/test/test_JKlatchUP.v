module _test_JKlatchUP;
   reg j, k, clk, reset;
   wire s1, s2;
   reg 	power = 1;

   integer i;

   JKlatchUP test_JKlatchUP(j, k, clk, reset, s1, s2);

   initial
     begin
	reset = 0;
	j = 1;
	k = 1;
	clk = 0;
	i = 0;
     end

   always
     begin
	#5;
//	reset = 0;
	clk = ~clk;
     end

   always @(posedge clk)
     begin
	if (i == 10)
	  begin
	     $finish;
	  end 
	i++;
     end
   
   initial
     begin
	$dumpfile("signal/signal_JKlatchUP.vcd");
	$dumpvars;
     end
   initial
     begin
	$display("\t\ttime, \tj, \tk, \tclk, \treset, \ts1, \ts2");
	$monitor("%d \t%b \t%b \t%b \t%b \t%b \t%b", $time, j, k, clk, reset, s1, s2);
     end
endmodule // test_JKlatchUP
