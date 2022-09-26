module test_gate;
   reg e1, e2;
   wire	out_not, out_nor, out_nand;

   gate_not  inst0(out_not, e1);
   gate_nor  inst1(out_nor, e1, e2);
   gate_nand inst2(out_nand, {e1, e2});

   initial
     begin
	$dumpfile("signal_gate.vcd");
        $dumpvars;
        $display("\t\ttime, \tnot, \tnor, \tnand, \te1, \te2");
        $monitor("%d \t%b\t%b\t%b\t%b\t%b", $time, out_not, out_nor, out_nand, e1, e2);

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
