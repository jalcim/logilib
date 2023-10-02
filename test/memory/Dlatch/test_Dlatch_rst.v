`include "src/memory/Dlatch/Dlatch_rst.v"

module test_Dlatch_rst;
   reg a, clk;
   reg reset;
   wire	s1, s2;

   reg [7:0] cpt;

   Dlatch_rst inst0(a, clk, reset, s1, s2);

   initial
     begin
	$dumpfile("signal_Dlatch.vcd");
        $dumpvars;
        $display("\t\ttime, \ta, \tclk, \treset, \ts1, \ts2");
        $display("\t\t-----------------------------------------");
        $monitor("%d \t%b\t%b\t%b\t%b\t%b", $time, a, clk, reset, s1, s2);
	a <= 0;
	clk <= 0;
	cpt <= 0;
	reset <= 1;
     end
   
   always
     begin
	#100;
	clk <= ~clk;
     end

   always @(posedge clk)
     begin
	cpt <= cpt + 1;

	if (cpt % 2)
	     a <= ~a;

	if (cpt % 3)
	  reset <= 1;
	else
	  reset <= 0;

	if (cpt > 10)
	     $finish;
     end
endmodule // test_Dlatch
