module test_recursive_buf;
   parameter S = 3;

   reg [7:0]  in;
   wire [7:0] out;

   recursive_buf #(.S(S))recursive_buf(in[7:0], out[7:0]);

   initial
     begin
	$dumpfile("build/primitive/signal/signal_recursive_buf.vcd");
	$dumpvars;
	$display("time\t");
	$monitor("%d\t%b\t%b\n", $time, in, out);

	in = 255;
	#5;
	in = 128;
	#5;
     end
endmodule // test_recursive_buf
