`include "src/memory/Dlatch/parallel_Dlatch_rst.v"

module test_parallel_Dlatch_rst;
   parameter WAY = 3;
   parameter WIRE = 8;

   reg [WAY -1: 0] clk, rst;
   reg [(WAY * WIRE)-1 : 0] D;
   wire [(WAY * WIRE)-1:0]  Q, QN;

   integer		    cpt;
   integer		    var_rst;

   parallel_Dlatch_rst #(.WAY(WAY), .WIRE(WIRE)) parallel_Dlatch_inst(D, clk, rst, Q, QN);

   initial
     begin
	$dumpfile("signal_parallel_Dlatch.vcd");
        $dumpvars;
        $display("\t\ttime, \tD, \tclk, \trst, \tQ, \tQN");
        $display("\t\t-----------------------------------------");
        $monitor("%d \t%b\t%b\t%b\t%b\t%b\n", $time, D, clk, rst, Q, QN);

	rst <= (2 **WAY) - 1;
	clk <= 0;
	D <= (2 ** (WAY*WIRE)) - 1;

	cpt <= 0;
	var_rst <= 0;
	#10;
	rst <= 0;
     end
   
   always
     begin
	#100;
	clk <= cpt;
	cpt <= cpt + 1;
	D <= ~D;

	if (cpt % 11)
	  begin
	     rst = 2**var_rst;
	     var_rst <= var_rst + 1;
	  end
	else
	  rst <= 0;

	if (cpt >= (2**WAY)-1)
	  $finish;
     end
endmodule // test_parallel_Dlatch
