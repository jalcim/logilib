module _test_cpt_bin;

   reg activate, clk, reset;
   wire [7:0] cpt;

   cpt_bin8 test_cpt_bin(activate, clk, reset, cpt);

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
	#20;
	$display("ALWAYS");
	clk = ~clk;
	$display("ALWAYS END");
     end

   always @(posedge clk)
     begin
	if (cpt >= 255)
	  begin
	     $display("FINISH");
	     $finish;
	  end
     end
   
   initial
     begin
	$dumpfile("signal/signal_cpt_bin.vcd");
	$dumpvars;
     end
   initial
     begin
	$display("\t\ttime, \tactivate, \tclk, \treset, \tcpt");
	$monitor("%d \t%b \t\t%b \t%b \t%d", $time, activate, clk, reset, cpt);
     end
endmodule // test_cpt_bin
