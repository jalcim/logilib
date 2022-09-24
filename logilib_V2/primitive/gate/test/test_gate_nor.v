module test_gate_nor;
   reg e1, e2;
   wire	out;

   gate_nor inst0(out, e1, e2);

   initial
     begin
	$dumpfile("signal_gate_nor.vcd");
        $dumpvars;
        $display("\t\ttime, \tout, \te1, \te2");
        $monitor("%d \t%b\t%b\t%b", $time, out, e1, e2);

	e1 <= 0;
	e2 <= 0;
	#10;
	e1 <= 1;
	#10;
	e1 <= 0;
	e2 <= 1;
	#10;
	e1 <= 1;
	#10;
     end
endmodule // test_gate_nor
