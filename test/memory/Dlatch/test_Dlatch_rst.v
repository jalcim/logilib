`include "src/memory/Dlatch/Dlatch_rst.v"

module test_Dlatch_rst;
   reg D, clk;
   reg reset;
   wire	s1, s2;

   integer cpt;

   Dlatch_rst inst0(D, clk, reset, s1, s2);

   initial
     begin
	$dumpfile("signal_Dlatch.vcd");
        $dumpvars;
        $display("\t\ttime, \ta, \tclk, \treset, \ts1, \ts2");
        $display("\t\t-----------------------------------------");
        $monitor("%d \t%b\t%b\t%b\t%b\t%b", $time, D, clk, reset, s1, s2);
	D <= 0;
	clk <= 0;
	cpt <= 0;
	reset <= 1;
     end
   
   always
     begin
	#100;
	clk <= ~clk;
	cpt <= cpt + 1;

	if (cpt % 3)
	  reset <= 1;
	else
	  reset <= 0;
     end

   always @(posedge clk)
     begin
	if (cpt % 2)
	     D <= ~D;

	if (cpt > 20)
	     $finish;
     end
endmodule
