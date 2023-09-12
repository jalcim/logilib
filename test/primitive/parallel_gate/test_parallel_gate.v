`include "src/primitive/parallel_gate/parallel_and.v"
//`include "src/primitive/parallel_gate/parallel_buf.v"
`include "src/primitive/parallel_gate/parallel_nand.v"
`include "src/primitive/parallel_gate/parallel_nor.v"
//`include "src/primitive/parallel_gate/parallel_not.v"
`include "src/primitive/parallel_gate/parallel_or.v"
`include "src/primitive/parallel_gate/parallel_xnor.v"
`include "src/primitive/parallel_gate/parallel_xor.v"

module test_parallel_gate;
   parameter WAY = 2;
   parameter WIRE = 2;

   reg  [WIRE-1:0] e1, e2;
   wire [WAY-1:0]  out_and, out_nand, out_nor, out_or, out_xnor, out_xor, out_not, out_buf;

   parallel_and  #(.WAY(WAY), .WIRE(WIRE)) parallel_and_inst (out_and,  {e1[0], e2[0], e1[1], e2[1]});
   parallel_nand #(.WAY(WAY), .WIRE(WIRE)) parallel_nand_inst(out_nand, {e1[0], e2[0], e1[1], e2[1]});
   parallel_nor  #(.WAY(WAY), .WIRE(WIRE)) parallel_nor_inst (out_nor,  {e1[0], e2[0], e1[1], e2[1]});
   parallel_or   #(.WAY(WAY), .WIRE(WIRE)) parallel_or_inst  (out_or,   {e1[0], e2[0], e1[1], e2[1]});
   parallel_xnor #(.WAY(WAY), .WIRE(WIRE)) parallel_xnor_inst(out_xnor, {e1[0], e2[0], e1[1], e2[1]});
   parallel_xor  #(.WAY(WAY), .WIRE(WIRE)) parallel_xor_inst (out_xor,  {e1[0], e2[0], e1[1], e2[1]});

   initial
     begin
	$dumpfile("signal_parallel_and.vcd");
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
