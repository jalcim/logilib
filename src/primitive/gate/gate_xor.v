`ifndef __GATE_XOR__
 `define __GATE_XOR__

 `include "src/primitive/parallel_gate/parallel_xor.v"
 `include "src/primitive/serial_gate/serial_xor.v"

module gate_xor(out, in);
   parameter WAY = 1;
   parameter WIRE = 2;

   localparam SIZE = WAY * WIRE;

   input [SIZE-1:0] in;
   output out;

   if (WAY > 1)
     parallel_xor #(.WAY(WAY), .WIRE(WIRE)) parallel_xor_inst(out, in);
   else
     serial_xor #(.WIRE(WIRE)) serial_xor_inst(out, in);
endmodule

`endif
