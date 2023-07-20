module test_parallel_buf;
   parameter SIZE = 8;

   reg  [7:0] A;
   wire [7:0] out;

   parallel_buf #(.SIZE(SIZE)) parallel_buf1(out, A);
   initial
     begin
	$dumpfile("signal_parallel_buf.vcd");
        $dumpvars;
        $display("\t\ttime, \tA, \t\tout");
        $monitor("%d \t%b\t%b", $time, A, out);

	A <= 0;
	#20;
	A <= 52;
	#20;
	A <= 158;
	#20;
     end
endmodule
