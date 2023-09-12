`include "src/primitive/serial_gate/serial_and.v"
//`include "src/primitive/serial_gate/serial_buf.v"
`include "src/primitive/serial_gate/serial_nand.v"
`include "src/primitive/serial_gate/serial_nor.v"
//`include "src/primitive/serial_gate/serial_not.v"
`include "src/primitive/serial_gate/serial_or.v"
`include "src/primitive/serial_gate/serial_xnor.v"
`include "src/primitive/serial_gate/serial_xor.v"

module test_serial_gate;
   parameter WIRE = 3;

   reg [WIRE-1:0] e1;
   wire out_and, out_nand, out_nor, out_or, out_xnor, out_xor, out_not, out_buf;
   reg	clk;
   integer i;

   serial_and #(.WIRE(WIRE)) test_serial_and(out_and, e1);
   serial_nand #(.WIRE(WIRE)) test_serial_nand(out_nand, e1);
   serial_nor #(.WIRE(WIRE)) test_serial_nor(out_nor, e1);
   serial_or #(.WIRE(WIRE)) test_serial_or(out_or, e1);
   serial_xnor #(.WIRE(WIRE)) test_serial_xnor(out_xnor, e1);
   serial_xor #(.WIRE(WIRE)) test_serial_xor(out_xor, e1);

   initial
     begin
	$dumpfile("signal_serial_and.vcd");
        $dumpvars;
        $display("\t\ttime, \te1, \tout");
	$monitor("time %d\ne1\t%b\ne2\t%b\ne3\t%b\nnot\t%b\nnor\t%b\nnand\t%b\nand\t%b\nor\t%b\nbuf\t%b\nxor\t%b\nxnor\t%b\n\n",
		 $time, e1[0], e1[1], e1[2],
		 out_not, out_nor, out_nand, out_and,
		 out_or , out_buf, out_xor , out_xnor);

	e1 <= 0;
	#20;
	e1 <= 1;
	#20;
	e1 <= 2;
	#20;
	e1 <= 3;
	#20;
	e1 <= 4;
	#20;
	e1 <= 5;
	#20;
	e1 <= 6;
	#20;
	e1 <= 7;
	#20;
     end
endmodule
