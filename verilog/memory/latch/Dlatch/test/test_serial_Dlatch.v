module test_serial_Dlatch;
   parameter SIZE = 8;
   reg clk, reset;
   wire	[7:0]s1, s2;
   reg [7:0] a, cpt;

   serial_Dlatch #(.SIZE(SIZE)) inst0(a, clk, reset, s1, s2);

   initial
     begin
	$dumpfile("signal_Dlatch.vcd");
        $dumpvars;
        $display("\t\ttime, \ta, \t\tclk, \treset, \ts1, \t\ts2");
        $display("\t\t----------------------------------------------------------------");
        $monitor("%d \t%b\t%b\t%b\t%b\t%b", $time, a, clk, reset, s1, s2);
	a <= 0;
	clk <= 0;
	reset <= 0;
	cpt <= 0;
     end
   
   always
     begin
	#100;
	clk <= ~clk;
     end
   
   always @(posedge clk)
     begin
	reset <= 0;
	cpt <= cpt + 1;
	if (cpt % 2)
	  begin
	     a <= cpt;
	  end
	if (!(cpt % 7))
	  begin
	     reset <= 1;
	  end
	if (cpt > 20)
	  begin
	     $finish;
	  end
     end

endmodule // test_Dlatch
