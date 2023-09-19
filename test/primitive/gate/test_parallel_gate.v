`include "src/primitive/gate/gate_and.v"
`include "src/primitive/gate/gate_buf.v"
`include "src/primitive/gate/gate_nand.v"
`include "src/primitive/gate/gate_nor.v"
`include "src/primitive/gate/gate_not.v"
`include "src/primitive/gate/gate_or.v"
`include "src/primitive/gate/gate_xnor.v"
`include "src/primitive/gate/gate_xor.v"

module test_parallel_gate;
   parameter WAY = 2;
   parameter WIRE = 2;

   reg [WIRE-1:0] e1, e2;
   wire [WAY-1:0] out_not, out_nor, out_nand, out_and, out_or , out_buf, out_xor , out_xnor;
   wire [WAY-1:0] b_out_nor, b_out_nand;

   gate_buf  #(                           .WIRE(WIRE)) gate_buf_inst (out_buf,   e1);
   gate_not  #(                           .WIRE(WIRE)) gate_not_inst (out_not,   e1);
   gate_and  #(                .WAY(WAY), .WIRE(WIRE)) gate_and_inst (out_and,  {e2, e1});
   gate_or   #(                .WAY(WAY), .WIRE(WIRE)) gate_or_inst  (out_or,   {e2, e1});
   gate_nand #(.BEHAVIORAL(0), .WAY(WAY), .WIRE(WIRE)) gate_nand_inst(out_nand, {e2, e1});
   gate_nor  #(.BEHAVIORAL(0), .WAY(WAY), .WIRE(WIRE)) gate_nor_inst (out_nor,  {e2, e1});
   gate_xnor #(                .WAY(WAY), .WIRE(WIRE)) gate_xnor_inst(out_xnor, {e2, e1});
   gate_xor  #(                .WAY(WAY), .WIRE(WIRE)) gate_xor_inst (out_xor,  {e2, e1});

   gate_nand #(.BEHAVIORAL(1), .WAY(WAY), .WIRE(WIRE)) b_gate_nand_inst(b_out_nand, {e2, e1});
   gate_nor  #(.BEHAVIORAL(1), .WAY(WAY), .WIRE(WIRE)) b_gate_nor_inst (b_out_nor,  {e2, e1});
//   gate_xnor #(.BEHAVIORAL(1), .WAY(WAY), .WIRE(WIRE)) b_gate_xnor_inst(out_xnor, {e2, e1});
//   gate_xor  #(.BEHAVIORAL(1), .WAY(WAY), .WIRE(WIRE)) b_gate_xor_inst (out_xor,  {e2, e1});

   initial
     begin
	$dumpfile("signal_test_parallel_gate.vcd");
	$dumpvars;
        $monitor("time %d\ne1\t%b\ne2\t%b\nnot\t%b\nnor\t%b\nnand\t%b\nand\t%b\nor\t%b\nbuf\t%b\nxor\t%b\nxnor\t%b\nb_nand\t%d\nb_nor\t%d\n\n",
		 $time, e1, e2,
		 out_not, out_nor, out_nand, out_and,
		 out_or , out_buf, out_xor , out_xnor,
		 b_out_nand, b_out_nor);

	e1 <= 2'b00;
	e2 <= 2'b00;//00 00
	#10;
	e1 <= 2'b01;//00 01
	#10;
	e1 <= 2'b10;//00 10
	#10;
	e1 <= 2'b11;//00 11
	#10;

	e1 <= 2'b00;
	e2 <= 2'b01;//01 00
	#10;
	e1 <= 2'b01;//01 01
	#10;
	e1 <= 2'b10;//01 10
	#10;
	e1 <= 2'b11;//01 11
	#10;

	e1 <= 2'b00;
	e2 <= 2'b10;//10 00
	#10;
	e1 <= 2'b01;//10 01
	#10;
	e1 <= 2'b10;//10 10
	#10;
	e1 <= 2'b11;//10 11
	#10;

	e1 <= 2'b00;
	e2 <= 2'b11;//11 00
	#10;
	e1 <= 2'b01;//11 01
	#10;
	e1 <= 2'b10;//11 10
	#10;
	e1 <= 2'b11;//11 11
	#10;
     end
endmodule
