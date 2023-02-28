module test_gate;
   reg e1, e2;
   wire	out_not, out_nor, out_nand;

   gate_not  inst0(out_not, e1);
   gate_nor  inst1(out_nor, e1, e2);
   gate_nand inst2(out_nand, {e1, e2});

   initial
     begin


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
