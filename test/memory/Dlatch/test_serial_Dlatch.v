`include "src/memory/Dlatch/serial_Dlatch.v"

module test_serial_Dlatch;
   parameter WIRE = 8;
   reg clk;
   wire	[7:0]s1, s2;
   reg [7:0] a, cpt;

   serial_Dlatch #(.WIRE(WIRE)) inst0(a, clk, s1, s2);

   initial
     begin
	$dumpfile("signal_Dlatch.vcd");
        $dumpvars;
        $display("\t\ttime, \ta, \t\tclk, \ts1, \t\ts2");
        $display("\t\t----------------------------------------------------------------");
        $monitor("%d \t%b\t%b\t%b\t%b", $time, a, clk, s1, s2);
	a <= 0;
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
	     a <= cpt;
	  end
	if (cpt > 20)
	  begin
	     $finish;
	  end
     end

endmodule // test_Dlatch
