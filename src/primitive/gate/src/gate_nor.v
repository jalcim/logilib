`ifndef __GATE_NOR__
 `define __GATE_NOR__

module gate_nor(out, in);
   parameter SIZE = 2;
   input [1:0] in;
   output out;

   if (SIZE == 2)
     nor nor_inst(out, in[0], in[1]);
   else if (SIZE > 2)
     serial_nor #(.SIZE(SIZE)) serial_nor_inst(out, in);
endmodule

`endif
