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
   parameter WIRE = 8;

   reg  [WAY*WIRE-1:0] in;
   wire [WIRE-1:0]  out_and, out_nand, out_nor, out_or, out_xnor, out_xor, out_not, out_buf;
   wire [WIRE-1:0]  b_out_nand, b_out_nor;

   integer	   i;

   parallel_buf  #(                           .WIRE(WIRE)) parallel_buf_inst (out_buf,  in[7:0]);
   parallel_not  #(                           .WIRE(WIRE)) parallel_not_inst (out_not,  in[7:0]);
   parallel_and  #(                .WAY(WAY), .WIRE(WIRE)) parallel_and_inst (out_and,  in);
   parallel_nand #(.BEHAVIORAL(0), .WAY(WAY), .WIRE(WIRE)) parallel_nand_inst(out_nand, in);
   parallel_nor  #(.BEHAVIORAL(0), .WAY(WAY), .WIRE(WIRE)) parallel_nor_inst (out_nor,  in);
   parallel_or   #(                .WAY(WAY), .WIRE(WIRE)) parallel_or_inst  (out_or,   in);
   parallel_xnor #(                .WAY(WAY), .WIRE(WIRE)) parallel_xnor_inst(out_xnor, in);
   parallel_xor  #(                .WAY(WAY), .WIRE(WIRE)) parallel_xor_inst (out_xor,  in);

   parallel_nand #(.BEHAVIORAL(1), .WAY(WAY), .WIRE(WIRE)) b_gate_nand_inst(b_out_nand, in);
   parallel_nor  #(.BEHAVIORAL(1), .WAY(WAY), .WIRE(WIRE)) b_gate_nor_inst (b_out_nor,  in);

   initial
     begin
	$dumpfile("signal_test_parallel_gate.vcd");
	$dumpvars;
        $monitor("time %d\nin\t%b\nnot\t%b\nnor\t%b\nnand\t%b\nand\t%b\nor\t%b\nbuf\t%b\nxor\t%b\nxnor\t%b\nb_nand\t%b\nb_nor\t%b\n\n",
		 $time, in,
		 out_not, out_nor, out_nand, out_and,
		 out_or , out_buf, out_xor , out_xnor,
		 b_out_nand, b_out_nor);
	in <= 0;

	for (i = 0 ; i < (2**(WAY*WIRE)) ; i = i + 1)
	  begin
	     in = in + 1;
	     #1;
	     if ((in[0] ^ in[1]) != out_xor[0])
	       begin
		  $display ("error xor e1 e2 out %b %b %b\n", in[0], in[1], out_xor[0]);
		  $finish;
	       end
	     #1;
	  end	 
     end
endmodule
