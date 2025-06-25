`include "src/memory/dflipflop/serial/serial_Dflipflop_pre.v"

module test_serial_Dflipflop_pre;
   parameter WIRE = 8;
   reg clk;
   reg [7:0] D, pre;
   wire	[7:0]Q, QN;

   integer   cpt;

   serial_Dflipflop_pre #(.WIRE(WIRE)) inst0(D, clk, pre, Q, QN);

   initial
     begin
	$dumpfile("signal_Dflipflop_pre.vcd");
        $dumpvars;
        $display("\t\ttime, \tD, \t\tclk, \tpre, \tQ, \t\tQN");
        $display("\t\t----------------------------------------------------------------");
        $monitor("%d \t%b\t%b\t%b\t%b\t%b", $time, D, clk, pre, Q, QN);
	D <= 0;
	clk <= 0;
	cpt <= 0;
	pre <= 0;
     end

   always #100 clk <= ~clk;

   always @(posedge clk)
     begin
	if (cpt % 2)
	  D <= cpt;

	cpt <= cpt + 1;
	if (cpt > 20)
	  $finish;

	if (cpt % 7)
	  pre <= $random % WIRE;
	else
	  pre <= 0;
     end
endmodule
