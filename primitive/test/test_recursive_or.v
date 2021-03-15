module test_recursive_or;
   parameter S = 3;

   reg [7:0]  in1, in2;
   wire [7:0] out;

   recursive_or #(.S(S))recursive_or(in1[7:0], in2[7:0], out[7:0]);

   initial
     begin
	$dumpfile("build/primitive/signal/signal_recursive_or.vcd");
	$dumpvars;
	$display("time\t");
	$monitor("%d\t%b\t%b\t%b\n", $time, in1, in2, out);

	in1 = 252;
	in2 = 1;
	#5;
	in1 = 128;
	#5;
     end
endmodule // test_recursive_buf
