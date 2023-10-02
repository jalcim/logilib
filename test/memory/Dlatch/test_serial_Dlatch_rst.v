`include "src/memory/Dlatch/serial_Dlatch_rst.v"

module test_serial_Dlatch_rst;
   parameter WIRE = 8;
   reg clk, rst;
   wire	[7:0]s1, s2;
   reg [7:0] a, cpt;

   serial_Dlatch_rst #(.WIRE(WIRE)) inst0(a, clk, rst, s1, s2);

   initial
     begin
	$dumpfile("signal_Dlatch_rst.vcd");
        $dumpvars;
        $display("\t\ttime, \ta, \t\tclk, \trst, \ts1, \t\ts2");
        $display("\t\t----------------------------------------------------------------");
        $monitor("%d \t%b\t%b\t%b\t%b\t%b", $time, a, clk, rst, s1, s2);
	a <= 0;
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
	  a <= cpt;
	if (cpt > 20)
	  $finish;
     end

endmodule // test_Dlatch
