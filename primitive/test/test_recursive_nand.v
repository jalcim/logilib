module test_recursive_nand;
   parameter S = 3;

   reg [7:0]  in1, in2;
   wire [7:0] out;

   recursive_nand #(.S(S))recursive_nand(in1[7:0], in2[7:0], out[7:0]);

   initial
     begin
	$dumpfile("build/primitive/signal/signal_recursive_nand.vcd");
	$dumpvars;
	$display("time\t");
	$monitor("%d\t%b\t%b\t%b\n", $time, in1, in2, out);

	in1 = 252;
	in2 = 123;
	#5;
	in1 = 200;
	#5;
     end
endmodule // test_recursive_buf
