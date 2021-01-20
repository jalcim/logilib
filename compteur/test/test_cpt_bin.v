module _test_cpt_bin;

   reg activate, clk, reset;
   wire [7:0] cpt;
   reg [7:0]  sv;

   cpt_bin8 test_cpt_bin(activate, clk, reset, cpt);

   initial
     begin
	activate = 0;
	clk = 1;
	reset = 1;
	#5;
	clk = 0;
	reset = 0;
	activate = 1;
	#5;
	sv = 2;
     end

   always
     begin
	#20;
	clk = ~clk;
     end

   always @(posedge clk)
     begin
	if (sv == cpt)
	  begin
	     $display("error infinite loop");
	     $finish;
	  end
	sv = cpt;
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
//     end
//   initial
//     begin
	$display("\t\ttime, \tactivate, \tclk, \treset, \tcpt");
	$monitor("%d \t%b \t\t%b \t%b \t%d", $time, activate, clk, reset, cpt);
     end
endmodule // test_cpt_bin
