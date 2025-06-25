`include "src/memory/dflipflop/Dflipflop_rst.v"

module test_Dflipflop_rst;
   reg D, clk;
   reg reset;
   wire	Q, QN;

   integer cpt;

   Dflipflop_rst inst0(D, clk, reset, Q, QN);

   initial
     begin
	$dumpfile("signal_Dflipflop_rst.vcd");
        $dumpvars;
        $display("\t\ttime, \tD, \tclk, \treset, \tQ, \tQN");
        $display("\t\t-----------------------------------------");
        $monitor("%d \t%b\t%b\t%b\t%b\t%b", $time, D, clk, reset, Q, QN);
	D <= 0;
	clk <= 0;
	cpt <= 0;
	reset <= 1;
     end
   
   always #100 clk <= ~clk;

   always @(posedge clk)
     begin
	if (cpt % 2)
	  D <= ~D;

	cpt <= cpt + 1;
	if (cpt > 20)
	  $finish;

	if (cpt % 3)
	  reset <= 1;
	else
	  reset <= 0;
     end
endmodule
