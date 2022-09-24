module _test_multi_nor;
   parameter SIZE = 4;

   reg [SIZE-1:0] e1;
   wire out;
   reg	clk;

   multi_nor #(.SIZE(SIZE)) test_multi_nor(out, e1);

   initial
     begin
	$dumpfile("signal_multi_nor.vcd");
        $dumpvars;
        $display("\t\ttime, \te1, , \tclk \tout");
        $monitor("%d \t%b\t%b\t%b", $time, e1, clk, out);

	e1 <= 0;
	clk <= 0;
     end

   always
     begin
	#10;
	clk = ~clk;
     end

   always @(posedge clk)
     begin
	e1 <= e1 + 1;
	if (e1 >= 4'b1111 )
	  $finish;
     end
endmodule
