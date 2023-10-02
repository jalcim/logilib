`include "src/memory/JKlatch/JKlatch_rst.v"

module _test_JKlatchUP_rst;
   reg j, k, clk, reset;
   wire s1, s2;
   supply1 	power;

   integer i;

   JKlatchUP_rst test_JKlatchUP_rst(j, k, clk, reset, s1, s2);

   initial
     begin
	reset = 1;
	j = 1;
	k = 1;
	clk = 0;
	i = 0;
	$dumpfile("signal_JKlatchUP.vcd");
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
