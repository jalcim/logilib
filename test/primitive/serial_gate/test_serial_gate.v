`include "src/primitive/serial_gate/serial_and.v"
`include "src/primitive/serial_gate/serial_nand.v"
`include "src/primitive/serial_gate/serial_nor.v"
`include "src/primitive/serial_gate/serial_or.v"
`include "src/primitive/serial_gate/serial_xnor.v"
`include "src/primitive/serial_gate/serial_xor.v"

module test_serial_gate;
   parameter WAY = 3;

   reg [WAY-1:0] e1;
   wire		 out_and, out_nand, out_nor, out_or, out_xnor, out_xor;
   wire b_out_nand, b_out_nor;

   serial_and  #(                .WAY(WAY)) test_serial_and (out_and   , e1);
   serial_nor  #(.BEHAVIORAL(0), .WAY(WAY)) gate_nor_inst   (out_nor   , e1);
   serial_nand #(.BEHAVIORAL(0), .WAY(WAY)) gate_nand_inst  (out_nand  , e1);
   serial_or   #(                .WAY(WAY)) test_serial_or  (out_or    , e1);
   serial_xnor #(                .WAY(WAY)) test_serial_xnor(out_xnor  , e1);
   serial_xor  #(                .WAY(WAY)) test_serial_xor (out_xor   , e1);

   serial_nor  #(.BEHAVIORAL(1), .WAY(WAY)) b_gate_nor_inst (b_out_nor , e1);
   serial_nand #(.BEHAVIORAL(1), .WAY(WAY)) b_gate_nand_inst(b_out_nand, e1);

   initial
     begin
	$dumpfile("signal_test_serial_gate.vcd");
        $dumpvars;
        $monitor("time %d\ne1\t%b\ne2\t%b\ne3\t%b\nnor\t%b\nnand\t%b\nand\t%b\nor\t%b\nxor\t%b\nxnor\t%b\nb_nand\t%d\nb_nor\t%d\n\n",
		 $time, e1[0], e1[1], e1[2],
		 out_nor, out_nand, out_and,
		 out_or, out_xor , out_xnor,
		 b_out_nand, b_out_nor);

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
