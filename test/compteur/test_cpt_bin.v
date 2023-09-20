`include "src/compteur/cpt_bin.v"

module test_cpt_bin;
   parameter SIZE = 8;
   reg activate, clk, reset;
   wire [7:0] cpt;
   reg [7:0]  sv;

   cpt_bin #(.SIZE(SIZE)) test_cpt_bin(activate, clk, reset, cpt);

   initial
     begin
	$dumpfile("signal_cpt_bin.vcd");
	$dumpvars;
	$display("\t\ttime, \tactivate, \tclk, \treset, \tcpt");
	$monitor("%d \t%b \t\t%b \t%b \t%d", $time, activate, clk, reset, cpt);
	
	activate <= 0;
	clk <= 0;
	reset <= 1;
	#5;
	clk <= 0;
	reset <= 0;
	activate <= 1;
	#5;
	sv <= 2;
     end

   always
     begin
	#20;
	clk <= ~clk;
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

endmodule // test_cpt_bin
