`ifndef __SLTU__
 `define __SLTU__

module sltu(datain_A, datain_B, out);
   parameter WIRE = 32;
   input [WIRE-1:0] datain_A, datain_B;
   output [WIRE-1:0] out;

   assign out[0] = datain_A < datain_B;
   assign out[WIRE-1:1] = 0;
endmodule

`endif
