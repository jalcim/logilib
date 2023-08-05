module _test_serial_JKlatchUP;
   reg [7:0] j, k;
   reg clk, reset;
   wire s1, s2;
   supply1 	power;

   integer i;

   serial_JKlatchUP #(.SIZE(8)) test_serial_JKlatchUP(j, k, clk, reset, s1, s2);

   initial
     begin
	reset = 1;
	j = 1;
	k = 1;
	clk = 0;
	i = 0;
	$dumpfile("build/memory/signal/signal_JKlatchUP.vcd");
	$dumpvars;
	$display("\t\ttime, \tj, \tk, \tclk, \treset, \ts1, \ts2");
	$monitor("%d \t%b \t%b \t%b \t%b \t%b \t%b", $time, j, k, clk, reset, s1, s2);
     end

   always
     begin
	if (reset && clk == 1)
	  begin
	     reset = 0;
	  end
	if (i >= 10 && !clk)
	  begin
	     $finish;
	  end 
	clk = ~clk;
	#5;
     end

   always @(posedge clk)
     begin
	i++;
     end
   
endmodule // test_JKlatchUP
