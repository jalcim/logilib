module test_and8;
   reg [7:0] e1, e2;
   wire [7:0] s;

   gate_and8 and0(e1, e2, s);

   initial
     begin
	$dumpfile("signal/signal_and8.vcd");
	$dumpvars;
	$display("\t\ttime,\te1,\te2,\ts");
	$monitor("%d,\t%d,\t%d,\t%d", $time, e1, e2, s);

	e1 = 5;
	e2 = 3;
	#5;
     end // initial begin
endmodule // test_and8


   
