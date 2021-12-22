module test_serial_and;
   parameter SIZE = 8;
   reg [SIZE - 1:0] e1;
   wire 	    out;

   serial_and test_and(out, e1);

   initial
     begin
	$dumpfile("build/primitive/signal/signal_test_serial_and.vcd");
	$dumpvars;
	$display("serial_and");
	$display("\t\ttime,\ta,\tb,\ts");
	$monitor("%d\t%b\t%b\t%b", $time, out, e1, s);

	e1 <= 8'b01110110;
	e1 <= 8'b11111111;
	e1 <= 8'b00000000;	
     end
endmodule
