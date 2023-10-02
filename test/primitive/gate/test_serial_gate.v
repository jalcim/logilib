`include "src/primitive/gate/gate_and.v"
`include "src/primitive/gate/gate_nand.v"
`include "src/primitive/gate/gate_nor.v"
`include "src/primitive/gate/gate_or.v"
`include "src/primitive/gate/gate_xnor.v"
`include "src/primitive/gate/gate_xor.v"

module test_serial_gate;
   parameter WAY = 3;
   reg e1, e2, e3;
   wire out_nor, out_nand, out_and, out_or, out_xor, out_xnor;
   wire	b_out_nor, b_out_nand;

   gate_and  #(                .WAY(WAY)) gate_and_inst (out_and,   {e3, e2, e1});
   gate_or   #(                .WAY(WAY)) gate_or_inst  (out_or,    {e3, e2, e1});
   gate_nor  #(.BEHAVIORAL(0), .WAY(WAY)) gate_nor_inst (out_nor,   {e3, e2, e1});
   gate_nand #(.BEHAVIORAL(0), .WAY(WAY)) gate_nand_inst(out_nand,  {e3, e2, e1});
   gate_xor  #(                .WAY(WAY)) gate_xor_inst (out_xor,   {e3, e2, e1});
   gate_xnor #(                .WAY(WAY)) gate_xnor_inst(out_xnor,  {e3, e2, e1});

   gate_nor  #(.BEHAVIORAL(1), .WAY(WAY)) b_gate_nor_inst (b_out_nor,   {e3, e2, e1});
   gate_nand #(.BEHAVIORAL(1), .WAY(WAY)) b_gate_nand_inst(b_out_nand,  {e3, e2, e1});

   initial
     begin
	$dumpfile("signal_test_serial_gate.vcd");
        $dumpvars;
        $monitor("time %d\ne1\t%b\ne2\t%b\ne3\t%b\nnor\t%b\nnand\t%b\nand\t%b\nor\t%b\nxor\t%b\nxnor\t%b\nb_nand\t%d\nb_nor\t%d\n\n",
		 $time, e1, e2, e3,
		 out_nor, out_nand, out_and,
		 out_or, out_xor , out_xnor,
		 b_out_nand, b_out_nor);

	e1 <= 0;
	e2 <= 0;
	e3 <= 0;
	#10;
	e1 <= 1;
	#10;
	e1 <= 0;
	e2 <= 1;
	#10;
	e1 <= 1;
	#10;

	e1 <= 0;
	e2 <= 0;
	e3 <= 1;
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
