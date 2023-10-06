`include "src/memory/Dlatch/Dlatch_pre.v"

module test_Dlatch_pre;
   reg D, clk;
   reg preset;
   wire	Q, QN;

   reg [7:0] cpt;

   Dlatch_pre inst0(D, clk, preset, Q, QN);

   initial
     begin
	$dumpfile("signal_Dlatch.vcd");
        $dumpvars;
        $display("\t\ttime, \tD, \tclk, \tpreset, \tQ, \tQN");
        $display("\t\t-----------------------------------------");
        $monitor("%d \t%b\t%b\t%b\t%b\t%b", $time, D, clk, preset, Q, QN);
	D <= 0;
	clk <= 0;
	cpt <= 0;
	preset <= 1;
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
     end

   always @(posedge clk)
     begin
	if (cpt % 2)
	  D <= ~D;

	if (cpt > 20)
	     $finish;
     end
endmodule
