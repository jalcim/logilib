`include "src/memory/Dlatch/Dlatch.v"

module test_Dlatch;
   reg a, clk;
   wire	s1, s2;

   reg [7:0] cpt;

   Dlatch inst0(a, clk, s1, s2);

   initial
     begin
	$dumpfile("signal_Dlatch.vcd");
        $dumpvars;
        $display("\t\ttime, \ta, \tclk, \ts1, \ts2");
        $display("\t\t-----------------------------------------");
        $monitor("%d \t%b\t%b\t%b\t%b", $time, a, clk, s1, s2);
	a <= 0;
	clk <= 0;
	cpt <= 0;
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
	  begin
	     a <= ~a;
	  end

	if (cpt > 5)
	  begin
	     $finish;
	  end
     end
endmodule // test_Dlatch
