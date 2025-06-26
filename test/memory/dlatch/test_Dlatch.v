`include "src/memory/dlatch/Dlatch.v"

module test_Dlatch;
   reg D, clk;
   wire	Q, QN;

   integer cpt;

   Dlatch inst0(D, clk, Q, QN);

   initial
     begin
	$dumpfile("signal_Dlatch.vcd");
        $dumpvars;
        $display("\t\ttime, \tD, \tclk, \tQ, \tQN");
        $display("\t\t-----------------------------------------");
        $monitor("%d \t%b\t%b\t%b\t%b", $time, D, clk, Q, QN);
	D <= 0;
	clk <= 0;
	cpt <= 0;
     end
   
   always #100 clk <= ~clk;

   always @(posedge clk)
     begin

	if (cpt % 2)
	  begin
	     D <= ~D;
	  end

	cpt <= cpt + 1;
	if (cpt > 10)
	  begin
	     $finish;
	  end
     end
endmodule // test_Dlatch
