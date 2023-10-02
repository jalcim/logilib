`include "src/memory/JKlatch/serial_JKlatch_rst.v"

module _test_serial_JKlatchUP_rst;
   reg [7:0] j, k;
   reg clk, reset;
   wire [7:0] s1, s2;
   supply1 	power;

   integer i;

   serial_JKlatchUP_rst #(.SIZE(8)) test_serial_JKlatchUP_rst(j, k, clk, reset, s1, s2);

   initial
     begin
	reset = 1;
	j = 0;
	k = 0;
	clk = 0;
	i = 0;
	$dumpfile("signal_JKlatchUP.vcd");
	$dumpvars;
	$display("\t\ttime, \tj, \t\tk, \t\tclk, reset, \ts1, \t\ts2");
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
	clk <= ~clk;
	j <= {$random} %255;
	k <= {$random} %255;
	#5;
     end

   always @(posedge clk)
     begin
	i++;
     end
   
endmodule // test_JKlatchUP
