`include "src/primitive/parallel_gate/parallel_and.v"
`include "src/primitive/parallel_gate/parallel_buf.v"
`include "src/primitive/parallel_gate/parallel_nand.v"
`include "src/primitive/parallel_gate/parallel_nor.v"
`include "src/primitive/parallel_gate/parallel_not.v"
`include "src/primitive/parallel_gate/parallel_or.v"
`include "src/primitive/parallel_gate/parallel_xnor.v"
`include "src/primitive/parallel_gate/parallel_xor.v"

module test_parallel_gate;

   parameter WAY = 2;
   parameter WIRE = 2;

   reg  [WIRE-1:0] e1, e2;
   wire [WAY-1:0]  out_and, out_nand, out_nor, out_or, out_xnor, out_xor, out_not, out_buf;
   wire [WAY-1:0]  b_out_nand, b_out_nor;

   parallel_buf  #(                           .WIRE(WIRE)) parallel_buf_inst (out_buf,  {       e1[1],        e1[0]});
   parallel_not  #(                           .WIRE(WIRE)) parallel_not_inst (out_not,  {       e1[1],        e1[0]});
   parallel_and  #(                .WAY(WAY), .WIRE(WIRE)) parallel_and_inst (out_and,  {e2[1], e1[1], e2[0], e1[0]});
   parallel_nand #(.BEHAVIORAL(0), .WAY(WAY), .WIRE(WIRE)) parallel_nand_inst(out_nand, {e2[1], e1[1], e2[0], e1[0]});
   parallel_nor  #(.BEHAVIORAL(0), .WAY(WAY), .WIRE(WIRE)) parallel_nor_inst (out_nor,  {e2[1], e1[1], e2[0], e1[0]});
   parallel_or   #(                .WAY(WAY), .WIRE(WIRE)) parallel_or_inst  (out_or,   {e2[1], e1[1], e2[0], e1[0]});
   parallel_xnor #(                .WAY(WAY), .WIRE(WIRE)) parallel_xnor_inst(out_xnor, {e2[1], e1[1], e2[0], e1[0]});
   parallel_xor  #(                .WAY(WAY), .WIRE(WIRE)) parallel_xor_inst (out_xor,  {e2[1], e1[1], e2[0], e1[0]});

   parallel_nand #(.BEHAVIORAL(1), .WAY(WAY), .WIRE(WIRE)) b_gate_nand_inst(b_out_nand, {e2[1], e1[1], e2[0], e1[0]});
   parallel_nor  #(.BEHAVIORAL(1), .WAY(WAY), .WIRE(WIRE)) b_gate_nor_inst (b_out_nor,  {e2[1], e1[1], e2[0], e1[0]});

   initial
     begin
	$dumpfile("signal_test_parallel_gate.vcd");
	$dumpvars;
        $monitor("time %d\ne1\t%b\ne2\t%b\ne3\t%b\nnot\t%b\nnor\t%b\nnand\t%b\nand\t%b\nor\t%b\nbuf\t%b\nxor\t%b\nxnor\t%b\nb_nand\t%d\nb_nor\t%d\n\n",
		 $time, e1, e2,
		 out_not, out_nor, out_nand, out_and,
		 out_or , out_buf, out_xor , out_xnor,
		 b_out_nand, b_out_nor);

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
