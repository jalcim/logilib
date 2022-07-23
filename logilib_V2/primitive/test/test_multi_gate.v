module _test_multi_gate;
   parameter SIZE = 6;

   parameter GATE2 = 2;
   parameter GATE3 = 3;
   parameter GATE4 = 4;
   parameter GATE5 = 5;
   parameter GATE6 = 6;
   parameter GATE7 = 7;

   reg [SIZE-1:0] e1;
   wire [5:0] 	  out;

   multi_gate #(.GATE(GATE2), .SIZE(SIZE)) test_multi_gate2(out[0], e1);
   multi_gate #(.GATE(GATE3), .SIZE(SIZE)) test_multi_gate3(out[1], e1);
   multi_gate #(.GATE(GATE4), .SIZE(SIZE)) test_multi_gate4(out[2], e1);
   multi_gate #(.GATE(GATE5), .SIZE(SIZE)) test_multi_gate5(out[3], e1);
   multi_gate #(.GATE(GATE6), .SIZE(SIZE)) test_multi_gate6(out[4], e1);
   multi_gate #(.GATE(GATE7), .SIZE(SIZE)) test_multi_gate7(out[5], e1);

   initial
     begin
	$dumpfile("signal_JKlatchUP.vcd");
        $dumpvars;
        $display("\t\ttime, \te1, \tout");
        $monitor("%d \t%b\t%b", $time, e1, out);

	e1 = 0;
	#100;
	e1 = 63;
	#100;
	e1 = 3;
	#100;
     end
endmodule
