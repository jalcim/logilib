`include "src/memory/Dflipflop/Dflipflop.v"

module test_serial_Dflipflop;
   parameter WIRE = 8;
   reg clk;
   wire	[7:0]Q, QN;
   reg [7:0] D;

   integer   cpt;

   Dflipflop #(.WIRE(WIRE)) Dflipflop_inst(D, clk, Q, QN);

   initial
     begin
	$dumpfile("signal_Dflipflop.vcd");
        $dumpvars;
        $display("\t\ttime, \tD, \t\tclk, \tQ, \t\tQN");
        $display("\t\t----------------------------------------------------------------");
        $monitor("%d \t%b\t%b\t%b\t%b", $time, D, clk, Q, QN);
	D <= 0;
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
	     D <= cpt;
	  end
	if (cpt > 20)
	  begin
	     $finish;
	  end
     end

endmodule
