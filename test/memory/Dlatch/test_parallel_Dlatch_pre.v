`include "src/memory/Dlatch/parallel_Dlatch/parallel_Dlatch_pre.v"

module test_parallel_Dlatch_pre;
   parameter WAY = 3;
   parameter WIRE = 8;

   reg [WAY -1: 0] clk;
   reg [(WAY * WIRE)-1 : 0] D, pre;
   wire [(WAY * WIRE)-1:0]  Q, QN;

   integer		    cpt;

   parallel_Dlatch_pre #(.WAY(WAY), .WIRE(WIRE)) parallel_Dlatch_inst(D, clk, pre, Q, QN);

   initial
     begin
	$dumpfile("signal_parallel_Dlatch_pre.vcd");
        $dumpvars;
        $display("\t\ttime, \tD, \t\t\t\tclk, \tpre, \t\t\t\tQ, \t\t\t\tQN");
        $display("\t\t-----------------------------------------");
        $monitor("%d \t%b\t%b\t%b\t%b\t%b\n", $time, D, clk, pre, Q, QN);

	clk <= 0;
	pre <= (2 **(WAY*WIRE)) - 1;
	cpt <= 0;
	D <= (2 ** (WAY*WIRE)) - 1;
     end

   always
     begin
	#100;
	clk <= cpt;
	cpt <= cpt + 1;
	$display ("cpt = %d\n", cpt);
	
	D <= ~D;

	if (cpt % 3)
	  pre = $random % (2**(WAY*WIRE));
	else
	  pre <= 0;

	if (cpt >= ((2**WAY)-1))
	  $finish;
     end
endmodule
