`include "src/memory/dflipflop/Dflipflop.v"

module test_Dflipflop;
   reg D, clk;
   wire	Q, QN;

   integer cpt;

   Dflipflop inst0(D, clk, Q, QN);

   initial
     begin
	$dumpfile("signal_Dflipflop.vcd");
        $dumpvars;
        $display("\t\ttime, \tD, \tclk, \tQ, \tQN");
        $display("\t\t-----------------------------------------");
        $monitor("%d \t%b\t%b\t%b\t%b", $time, D, clk, Q, QN);
	D <= 0;
	clk <= 0;
	cpt <= 0;
     end
   
   always
     begin
	#100;
	clk <= ~clk;   
	cpt <= cpt + 1;
     end

   always @(posedge clk)
     begin

	if (cpt % 2)
	  begin
	     D <= ~D;
	  end

	if (cpt > 10)
	  begin
	     $finish;
	  end
     end
endmodule
