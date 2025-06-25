`include "src/memory/dflipflop/parallel/parallel_Dflipflop_rst.v"

module test_parallel_Dflipflop_rst;
   parameter WAY = 3;
   parameter WIRE = 8;

   reg [WAY -1: 0] clk, rst;
   reg [(WAY * WIRE)-1 : 0] D;
   wire [(WAY * WIRE)-1:0]  Q, QN;

   integer		    cpt;
   integer		    var_rst;

   parallel_Dflipflop_rst #(.WAY(WAY), .WIRE(WIRE)) parallel_Dflipflop_inst(D, clk, rst, Q, QN);

   initial
     begin
	$dumpfile("signal_parallel_Dflipflop_rst.vcd");
        $dumpvars;
        $display("\t\ttime, \tD, \t\t\t\tclk, \trst, \tQ, \t\t\t\tQN");
        $display("\t\t-----------------------------------------");
        $monitor("%d \t%b\t%b\t%b\t%b\t%b\n", $time, D, clk, rst, Q, QN);

	rst <= (2 **WAY) - 1;
	clk <= 0;
	D <= (2 ** (WAY*WIRE)) - 1;

	cpt <= 0;
	var_rst <= 0;
     end

   always #100 clk <= ~clk;

   always @(posedge clk)
     begin
	if (cpt % 2)
	  D <= $random % (2**(WAY*WIRE)-1);

	cpt <= cpt + 1;
	if (cpt >= (2**WAY)-1)
	  $finish;

	if (cpt % 11)
	  begin
	     rst = 2**var_rst;
	     var_rst <= var_rst + 1;
	  end
	else
	  rst <= 0;
     end
endmodule
