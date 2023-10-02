`ifndef __SLTU__
 `define __SLTU__

module sltu(datain_A, datain_B, out);
   parameter WIRE = 32;
   input [WIRE-1:0] datain_A, datain_B;
   output [WIRE-1:0] out;

   assign out = datain_A < datain_B;
endmodule

`endif
