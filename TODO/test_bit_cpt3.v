`include "src/compteur/bit_cpt3.v"

module _test_bit_cpt3;

   reg activate, clk, reset;
   wire [2:0] cpt;

   bit_cpt3 test_bit_cpt3(activate, clk, reset, cpt);

   initial
     begin
	$dumpfile("build/compteur/signal/signal_bit_cpt3.vcd");
	$dumpvars;
	$display("\t\ttime, \tactivate, \tclk, \treset, \tcpt");
	$monitor("%d \t%b \t\t%b \t%b \t%d", $time, activate, clk, reset, cpt);
	
	clk = 1;
	reset = 1;
	activate = 0;
	#5;
	clk = 0;
	reset = 0;
	activate = 1;
	#5;
     end

   always
     begin
	#20
	clk = ~clk;
     end

   always @(posedge clk)
     begin
	if (cpt >= 4)
	  begin
	     $finish;
	  end
     end

endmodule // test_bit_cpt3
