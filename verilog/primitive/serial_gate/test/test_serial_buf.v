module _test_serial_buf;
   parameter SIZE = 8;

   reg e1;
   wire [SIZE-1:0] out;
   reg	clk;
   integer i;

   serial_buf #(.SIZE(SIZE)) test_serial_and(out, e1);

   initial
     begin
	$dumpfile("signal_serial_buf.vcd");
        $dumpvars;
        $display("\t\ttime, \te1, \tout");
        $monitor("%d \t%b\t%b", $time, e1, out);

	e1 <= 0;
	#20;
	e1 <= 1;
	#20;
	e1 <= 0;
	#20;
     end
endmodule
