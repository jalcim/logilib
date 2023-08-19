`ifndef __GATE_BUF__
 `define __GATE_BUF__

module gate_buf(out, in);
   parameter SIZE = 1;
   input in;
   output [SIZE-1:0] out;

   if (SIZE == 2)
     buf buf_inst(out, in);
   else if (SIZE > 2)
     serial_buf #(.SIZE(SIZE)) serial_buf_inst(out, in);
endmodule

`endif
