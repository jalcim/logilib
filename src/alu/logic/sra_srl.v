`ifndef __SRL__
 `define __SRL__

module srl(datain_A, datain_B, out);
   parameter WIRE = 32;
   input [WIRE-1:0] datain_A, datain_B;
   output [WIRE-1:0] out;

   assign out = datain_A >> datain_B[5:0];
endmodule

`endif
