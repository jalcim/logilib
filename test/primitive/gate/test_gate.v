`include "src/primitive/gate/gate_and.v"
//`include "src/primitive/gate/gate_buf.v"
`include "src/primitive/gate/gate_nand.v"
`include "src/primitive/gate/gate_nor.v"
//`include "src/primitive/gate/gate_not.v"
`include "src/primitive/gate/gate_or.v"
`include "src/primitive/gate/gate_xnor.v"
`include "src/primitive/gate/gate_xor.v"

module test_gate;
   reg e1, e2;
   wire out_not, out_nor, out_nand, out_and, out_or, out_xor, out_buf, out_xnor;

//   gate_not  inst0(out_not ,  e1);
   gate_nor  inst1(out_nor , {e1, e2});
   gate_nand inst2(out_nand, {e1, e2});
   gate_and  inst3(out_and , {e1, e2});
   gate_or   inst4(out_or  , {e1, e2});
   gate_xor  inst5(out_xor , {e1, e2});
//   gate_buf  inst6(out_buf ,  e1);
   gate_xnor inst7(out_xnor , {e1, e2});

   initial
     begin
	$dumpfile("signal_test_gate.vcd");
        $dumpvars;
        $monitor("time %d\ne1\t%b\ne2\t%b\nnot\t%b\nnor\t%b\nnand\t%b\nand\t%b\nor\t%b\nbuf\t%b\nxor\t%b\nxnor\t%b\n\n",
		 $time, e1, e2,
		 out_not, out_nor, out_nand, out_and,
		 out_or , out_buf, out_xor , out_xnor);

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
