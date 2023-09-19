`ifndef __GATE_XOR__
 `define __GATE_XOR__

 `include "src/primitive/parallel_gate/parallel_xor.v"
 `include "src/primitive/serial_gate/serial_xor.v"
 `include "src/routing/shuffle.v"

module gate_xor(out, in);
   parameter WAY = 2;
   parameter WIRE = 1;

   localparam SIZE = WAY * WIRE;

   input [SIZE-1:0] in;
   output [WIRE-1:0] out;

   if (WIRE > 1)
     begin
	wire [SIZE-1 : 0]  shuffle_out;

	shuffle      #(.WAY(WAY), .WIRE(WIRE)) shuffle_inst(shuffle_out, in);//2 voie de 8 bit
	parallel_xor #(.WAY(WAY), .WIRE(WIRE)) parallel_xor_inst(out, shuffle_out);//8 voie de 2 bit
     end
   else
     serial_xor #(.WAY(WAY)) serial_xor_inst(out, in);
endmodule

`endif
