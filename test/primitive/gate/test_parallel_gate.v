`include "src/primitive/gate/gate_and.v"
//`include "src/primitive/gate/gate_buf.v"
`include "src/primitive/gate/gate_nand.v"
`include "src/primitive/gate/gate_nor.v"
//`include "src/primitive/gate/gate_not.v"
`include "src/primitive/gate/gate_or.v"
`include "src/primitive/gate/gate_xnor.v"
`include "src/primitive/gate/gate_xor.v"

module test_parallel_gate;
   parameter WAY = 2;
   parameter WIRE = 2;

   reg  [WIRE-1:0] e1, e2;
   wire [WAY-1:0]  out_and, out_nand, out_nor, out_or, out_xnor, out_xor, out_not, out_buf;

   gate_and  #(.WAY(WAY), .WIRE(WIRE)) gate_and_inst (out_and,  {e1[0], e2[0], e1[1], e2[1]});
   gate_nand #(.WAY(WAY), .WIRE(WIRE)) gate_nand_inst(out_nand, {e1[0], e2[0], e1[1], e2[1]});
   gate_nor  #(.WAY(WAY), .WIRE(WIRE)) gate_nor_inst (out_nor,  {e1[0], e2[0], e1[1], e2[1]});
   gate_or   #(.WAY(WAY), .WIRE(WIRE)) gate_or_inst  (out_or,   {e1[0], e2[0], e1[1], e2[1]});
   gate_xnor #(.WAY(WAY), .WIRE(WIRE)) gate_xnor_inst(out_xnor, {e1[0], e2[0], e1[1], e2[1]});
   gate_xor  #(.WAY(WAY), .WIRE(WIRE)) gate_xor_inst (out_xor,  {e1[0], e2[0], e1[1], e2[1]});

   initial
     begin
	$dumpfile("signal_parallel_gate_and.vcd");
	$dumpvars;
	        $display("\t\ttime, \te1, \tout");
	$monitor("time %d\ne1\t%b\ne2\t%b\ne3\t%b\nnot\t%b\nnor\t%b\nnand\t%b\nand\t%b\nor\t%b\nbuf\t%b\nxor\t%b\nxnor\t%b\n\n",
		 $time, e1[0], e1[1], e1[2],
		 out_not, out_nor, out_nand, out_and,
		 out_or , out_buf, out_xor , out_xnor);

	e1 <= 0;
	e2 <= 0;
	#10;
	e1 <= 3;
	#10;
	e1 <= 0;
	e2 <= 3;
	#10;
	e1 <= 3;
	#10;
     end
endmodule
