module test_bit_cpt3;

   reg activate, clk, reset;
   wire [2:0] cpt;

   bit_cpt3 test_bit_cpt3(activate, clk, reset, cpt);

   initial
     begin
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
	clk = ~clk;
	#5;
     end // initial begin

   always @(posedge clk)
     begin
	if (cpt >= 4)
	  begin
	     $stop;
	  end
     end
   initial
     begin
	$dumpfile("signal/signal_bit_cpt3.vcd");
	$dumpvars;
     end
   initial
     begin
	$display("\t\ttime, \tactivate, \tclk, \treset, \tcpt");
	$monitor("%d \t%b \t\t%b \t%b \t%d", $time, activate, clk, reset, cpt);
     end
endmodule // test_bit_cpt3
