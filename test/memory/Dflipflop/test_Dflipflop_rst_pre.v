`include "src/memory/Dflipflop/Dflipflop_rst_pre.v"

module test_Dflipflop_rst_pre;
   reg D, preset;
   reg clk, reset;
   wire	Q, QN;

   integer cpt;

   Dflipflop_rst_pre inst0(D, clk, reset, preset, Q, QN);

   initial
     begin
	$dumpfile("signal_Dflipflop_rst_pre.vcd");
        $dumpvars;
        $display("\t\ttime, \tD, \tclk, \treset, \tpreset, \tQ, \tQN");
        $display("\t\t-----------------------------------------");
        $monitor("%d \t%b\t%b\t%b\t%b\t%b", $time, D, clk, reset, preset, Q, QN);
	D <= 0;
	clk <= 0;
	cpt <= 0;
	preset <= 1;
	reset <= 0;
     end
   
   always
     begin
	#100;
	clk <= ~clk;
	cpt <= cpt + 1;

	if (cpt % 3)
	  preset <= 1;
	else
	  preset <= 0;

	if (cpt % 7)
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
