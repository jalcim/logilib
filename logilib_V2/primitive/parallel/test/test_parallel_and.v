module test_parallel_and;
   parameter SIZE = 8;
   reg  [SIZE-1:0] in1, in2;
   wire [SIZE-1:0] out;

   parrallel_and #(.SIZE(SIZE)) parral_and(in1, in2, out);

   initial
     begin
	$dumpfile("and.vcd");
        $dumpvars;
        $display("\t\ttime,\tin1,\tin2,\tout");
        $monitor("%d,\t%d,\t%d,\t%d", $time, in1, in2, out);

	in1 = 123;
	in2 = 124;
	#500;
     end
endmodule
