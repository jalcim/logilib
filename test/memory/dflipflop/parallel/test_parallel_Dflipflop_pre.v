`include "src/memory/dflipflop/parallel/parallel_Dflipflop_pre.v"

module test_parallel_Dflipflop_pre;
   parameter WAY = 3;
   parameter WIRE = 8;

   reg [WAY -1: 0] clk;
   reg [(WAY * WIRE)-1 : 0] D, pre;
   wire [(WAY * WIRE)-1:0]  Q, QN;

   integer		    cpt;

   parallel_Dflipflop_pre #(.WAY(WAY), .WIRE(WIRE)) parallel_Dflipflop_inst(D, clk, pre, Q, QN);

   initial
     begin
	$dumpfile("signal_parallel_Dflipflop_pre.vcd");
        $dumpvars;
        $display("\t\ttime, \tD, \t\t\t\tclk, \tpre, \t\t\t\tQ, \t\t\t\tQN");
        $display("\t\t-----------------------------------------");
        $monitor("%d \t%b\t%b\t%b\t%b\t%b\n", $time, D, clk, pre, Q, QN);

	clk <= 0;
	pre <= (2 **(WAY*WIRE)) - 1;
	cpt <= 0;
	D <= (2 ** (WAY*WIRE)) - 1;
     end

   always #100 clk <= ~clk;

   always @(posedge clk)
     begin
	if (cpt % 2)
	  D <= $random % (2**(WAY*WIRE)-1);

	cpt <= cpt + 1;
	if (cpt >= ((2**WAY)-1))
	  $finish;

	if (cpt % 3)
	  pre <= 0;
	else
	  pre = $random % (2**(WAY*WIRE)-1);

     end
endmodule
