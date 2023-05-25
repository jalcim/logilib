module test_gate;
   reg e1, e2;
   wire out_not, out_nor, out_nand, out_and, out_or, out_xor, out_xnor;

   gate_not  inst0(out_not ,  e1);
   gate_nor  inst1(out_nor , {e1, e2});
   gate_nand inst2(out_nand, {e1, e2});
   gate_and  inst3(out_and , {e1, e2});
   gate_or   inst4(out_or  , {e1, e2});
   gate_xor  inst5(out_xor , {e1, e2});
   gate_xnor inst6(out_xnor , {e1, e2});

   initial
     begin
	$dumpfile("signal_test_gate_cmos.vcd");
        $dumpvars;
        $monitor("time %d\nnot\t%b\nnor\t%b\nnand\t%b\nand\t%b\nor\t%b\nxor\t%b\nxnor\t%b\ne1\t%b\ne2\t%b\n",
		 $time, out_not, out_nor, out_nand,
		 out_and, out_or, out_xor, out_xnor,
		 e1, e2);

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
