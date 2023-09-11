`ifndef __GATE_BUF__
 `define __GATE_BUF__

 `include "../../serial_gate/src/serial_buf.v"

module gate_buf(out, in);
   parameter WAY = 1;
   parameter WIRE = 1;
   input in;
   output [WIRE-1:0] out;

   if (WAY == 1 && WIRE == 2)
     buf buf_inst(out, in);
   else if (WAY > 1)
     parallel_buf #(.WAY(WAY), .WIRE(WIRE)) parallel_buf_inst(out, in);
   else if (WIRE > 2)
     serial_buf #(.WIRE(WIRE)) serial_buf_inst(out, in);
endmodule

`endif
