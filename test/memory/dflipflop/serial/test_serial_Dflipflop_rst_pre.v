`include "src/memory/dflipflop/serial/serial_Dflipflop_rst_pre.v"

module test_serial_Dflipflop_rst_pre;
   parameter WIRE = 8;
   reg clk, rst;
   reg [7:0] D, pre;
   wire	[7:0]Q, QN;

   integer   cpt;

   serial_Dflipflop_rst_pre #(.WIRE(WIRE)) inst0(D, clk, rst, pre, Q, QN);

   initial
     begin
	$dumpfile("signal_Dflipflop_rst_pre.vcd");
        $dumpvars;
        $display("\t\ttime, \tD, \t\tclk, \trst, \tpre, \tQ, \t\tQN");
        $display("\t\t----------------------------------------------------------------");
        $monitor("%d \t%b\t%b\t%b\t%b\t%b\t%b", $time, D, clk, rst, pre, Q, QN);
	D <= 0;
	clk <= 0;
	cpt <= 0;
	pre <= 0;
	rst <= 0;
     end

   always
     begin
	#100;
	clk <= ~clk;
	cpt <= cpt + 1;
	if (cpt % 11)
	  rst <= $random % 2;
	else
	  rst <= 0;

	if (cpt % 3)
	  pre = $random % (2**WIRE);
	else
	  pre <= 0;

	if (cpt >= (2**WIRE)-1)
	  $finish;
     end

   always @(posedge clk)
     begin
	if (cpt % 2)
	  D <= cpt;
     end
endmodule
