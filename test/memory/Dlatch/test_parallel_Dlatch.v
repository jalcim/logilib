`include "src/memory/Dlatch/parallel_Dlatch.v"

module test_parallel_Dlatch;
   parameter WAY = 3;
   parameter WIRE = 8;

   reg [WAY -1: 0] clk;
   reg [(WAY * WIRE)-1 : 0] D;
   wire [(WAY * WIRE)-1:0]  Q, QN;

   integer		    cpt;

   parallel_Dlatch #(.WAY(WAY), .WIRE(WIRE)) parallel_Dlatch_inst(D, clk, Q, QN);

   initial
     begin
	$dumpfile("signal_parallel_Dlatch.vcd");
        $dumpvars;
        $display("\t\ttime, \tD, \tclk, \tQ, \tQN");
        $display("\t\t-----------------------------------------");
        $monitor("%d \t%b\t%b\t%b\t%b", $time, D, clk, Q, QN);

	D <= 0;
	clk <= (2 **WAY) - 1;
	#10;
	D <= (2 ** (WAY*WIRE)) - 1;
	clk <= 0;
	cpt <= 0;
     end
   
   always
     begin
	#100;
	clk <= cpt;
	cpt <= cpt + 1;
	D <= ~D;
	if (cpt >= (2**WAY)-1)
	  begin
	     $finish;
	  end
     end
endmodule // test_parallel_Dlatch
