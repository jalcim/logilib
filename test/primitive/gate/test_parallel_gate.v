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
   parameter WIRE = 8;

   reg  [WAY*WIRE-1:0] in;
   wire [WIRE-1:0] out_buf, out_not;
   wire [WIRE-1:0] out_nor, out_nand, out_and, out_or, out_xor , out_xnor;
   wire [WIRE-1:0] b_out_nor, b_out_nand;

   integer	  i, j;

   gate_buf  #(                           .WIRE(WIRE)) gate_buf_inst (out_buf,  in[7:0]);
   gate_not  #(                           .WIRE(WIRE)) gate_not_inst (out_not,  in[7:0]);
   gate_and  #(                .WAY(WAY), .WIRE(WIRE)) gate_and_inst (out_and,  in);
   gate_nand #(.BEHAVIORAL(0), .WAY(WAY), .WIRE(WIRE)) gate_nand_inst(out_nand, in);
   gate_nor  #(.BEHAVIORAL(0), .WAY(WAY), .WIRE(WIRE)) gate_nor_inst (out_nor,  in);
   gate_or   #(                .WAY(WAY), .WIRE(WIRE)) gate_or_inst  (out_or,   in);
   gate_xnor #(                .WAY(WAY), .WIRE(WIRE)) gate_xnor_inst(out_xnor, in);
   gate_xor  #(                .WAY(WAY), .WIRE(WIRE)) gate_xor_inst (out_xor,  in);

   gate_nand #(.BEHAVIORAL(1), .WAY(WAY), .WIRE(WIRE)) b_gate_nand_inst(b_out_nand, in);
   gate_nor  #(.BEHAVIORAL(1), .WAY(WAY), .WIRE(WIRE)) b_gate_nor_inst (b_out_nor,  in);

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
	     for (j = 0 ; j < (2**(WAY*WIRE)) ; j = j + 1)
	       begin
		  ////////////
		  if (in[j] != out_buf[j])
		    begin
		       $display ("error [%d] buf e1 out %b %b\n", j, in[j], out_buf[j]);
		       $finish;
		    end
		  else if (in[j] == out_not[j])
		    begin
		       $display ("error [%d] not e1 out %b %b\n", j, in[j], out_not[j]);
		       $finish;
		    end
		  else if ((in[j] ^ in[j+8]) != out_xor[j])
		    begin
		       $display ("error [%d] xor e1 e2 out %b %b %b\n", j, in[j], in[j+8], out_xor[j]);
		       $finish;
		    end
		  else if ((in[j] ^ in[j+8]) == out_xnor[j])
		    begin
		       $display ("error [%d] xnor e1 e2 out %b %b %b\n", j, in[j], in[j+8], out_xnor[j]);
		       $finish;
		    end
		  else if ((in[j] & in[j+8]) != out_and[j])
		    begin
		       $display ("error [%d] and e1 e2 out %b %b %b\n", j, in[j], in[j+8], out_and[j]);
		       $finish;
		    end
		  else if ((in[j] & in[j+8]) == out_nand[j])
		    begin
		       $display ("error [%d] nand e1 e2 out %b %b %b\n", j, in[j], in[j+8], out_nand[j]);
		       $finish;
		    end
		  else if ((in[j] | in[j+8]) != out_or[j])
		    begin
		       $display ("error [%d] nand e1 e2 out %b %b %b\n", j, in[j], in[j+8], out_nand[j]);
		       $finish;
		    end
		  else if ((in[j] | in[j+8]) == out_nor[j])
		    begin
		       $display ("error [%d] nand e1 e2 out %b %b %b\n", j, in[j], in[j+8], out_nand[j]);
		       $finish;
		    end
	       end
	     /////////
	  end
     end
endmodule
