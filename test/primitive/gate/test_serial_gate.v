`include "src/primitive/gate/gate_and.v"
//`include "src/primitive/gate/gate_buf.v"
`include "src/primitive/gate/gate_nand.v"
`include "src/primitive/gate/gate_nor.v"
//`include "src/primitive/gate/gate_not.v"
`include "src/primitive/gate/gate_or.v"
`include "src/primitive/gate/gate_xnor.v"
`include "src/primitive/gate/gate_xor.v"

module test_serial_gate;
   parameter WIRE = 3;
   reg e1, e2, e3;
   wire out_not, out_nor, out_nand, out_and, out_or, out_xor, out_buf, out_xnor;
   wire	b_out_nor, b_out_nand;

//   gate_not  #(.WIRE(WIRE)) inst0(out_not ,  e1);
//   gate_buf  #(.WIRE(WIRE)) inst6(out_buf ,  e1);
   gate_and  #(                .WIRE(WIRE)) gate_and_inst (out_and,   {e3, e2, e1});
   gate_or   #(                .WIRE(WIRE)) gate_or_inst  (out_or,    {e3, e2, e1});
   gate_nor  #(.BEHAVIORAL(0), .WIRE(WIRE)) gate_nor_inst (out_nor,   {e3, e2, e1});
   gate_nand #(.BEHAVIORAL(0), .WIRE(WIRE)) gate_nand_inst(out_nand,  {e3, e2, e1});
   gate_xor  #(                .WIRE(WIRE)) gate_xor_inst (out_xor,   {e3, e2, e1});
   gate_xnor #(                .WIRE(WIRE)) gate_xnor_inst(out_xnor,  {e3, e2, e1});

   gate_nor  #(.BEHAVIORAL(1), .WIRE(WIRE)) b_gate_nor_inst (b_out_nor,   {e3, e2, e1});
   gate_nand #(.BEHAVIORAL(1), .WIRE(WIRE)) b_gate_nand_inst(b_out_nand,  {e3, e2, e1});
//   gate_xor  #(.BEHAVIORAL(1), .WIRE(WIRE)) b_gate_xor_inst (out_xor,   {e3, e2, e1});
//   gate_xnor #(.BEHAVIORAL(1), .WIRE(WIRE)) b_gate_xnor_inst(out_xnor,  {e3, e2, e1});

   initial
     begin
	$dumpfile("signal_test_serial_gate.vcd");
        $dumpvars;
        $monitor("time %d\ne1\t%b\ne2\t%b\ne3\t%b\nnot\t%b\nnor\t%b\nnand\t%b\nand\t%b\nor\t%b\nbuf\t%b\nxor\t%b\nxnor\t%b\nb_nand\t%d\nb_nor\t%d\n\n",
		 $time, e1, e2, e3,
		 out_not, out_nor, out_nand, out_and,
		 out_or , out_buf, out_xor , out_xnor,
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
