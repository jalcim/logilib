`include "src/memory/dflipflop/serial/serial_Dflipflop_rst.v"

module test_serial_Dflipflop_rst;
   parameter WIRE = 8;
   reg clk, rst;
   wire	[7:0]Q, QN;
   reg [7:0] D;

   integer   cpt;

   serial_Dflipflop_rst #(.WIRE(WIRE)) inst0(D, clk, rst, Q, QN);

   initial
     begin
	$dumpfile("signal_Dflipflop_rst.vcd");
        $dumpvars;
        $display("\t\ttime, \tD, \t\tclk, \trst, \tQ, \t\tQN");
        $display("\t\t----------------------------------------------------------------");
        $monitor("%d \t%b\t%b\t%b\t%b\t%b", $time, D, clk, rst, Q, QN);
	D <= 0;
	clk <= 0;
	cpt <= 0;
	rst <= 0;
     end
   
   always
     begin
	#100;
	clk <= ~clk;
     end
   
   always @(posedge clk)
     begin
	cpt <= cpt + 1;
	if (cpt % 7)
	  rst <= ~rst;
	if (cpt % 2)
	  D <= cpt;
	if (cpt > 20)
	  $finish;
     end

endmodule
