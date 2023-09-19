`ifndef __GATE_AND__
 `define __GATE_AND__

 `include "src/primitive/parallel_gate/parallel_and.v"
 `include "src/primitive/serial_gate/serial_and.v"
 `include "src/routing/shuffle.v"

module gate_and(out, in);
   parameter WAY = 2;
   parameter WIRE = 1;

   localparam SIZE = WAY * WIRE;
   input [SIZE-1:0] in;
   output [WIRE-1:0] out;

   if (WIRE > 1)
     begin
	wire [SIZE-1 : 0]  shuffle_out;
	shuffle      #(.WAY(WAY), .WIRE(WIRE)) shuffle_inst(shuffle_out, in);//2 voie de 8 bit
	parallel_and #(.WAY(WAY), .WIRE(WIRE)) parallel_and_inst(out, shuffle_out);//8 voie de 2 bit
     end
   else
     serial_and   #(.WAY(WAY)) serial_and_inst(out, in);
endmodule

`endif
