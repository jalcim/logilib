`ifndef __GATE_AND__
 `define __GATE_AND__

module gate_and(out, in);
   parameter SIZE = 2;
   input [SIZE-1:0] in;
   output out;

   if (SIZE == 2)
     and and_inst(out, in[0], in[1]);
   else if (SIZE > 2)
     serial_and #(.SIZE(SIZE)) serial_and_inst(out, in);
endmodule

`endif
