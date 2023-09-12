`include "src/routing/decalleur_LR.v"

module test_decalleur_LR;

   reg [7:0] a;
   reg 	     lr;
   wire [7:0] s;
   
   dec_LR #(.WAY(8)) test_dec_LR(a, lr, s);

   
   initial
     begin
	$dumpfile("signal_or.vcd");
	$dumpvars;
        $display("\t\ttime, \ta, \tlr, \ts");
	$monitor("%d \t%d \t%b \t%d", $time, a, lr, s);

	a = 16;
	lr = 0;
	#5;
	lr = 1;	
     end
   
   
endmodule // test_regdec
