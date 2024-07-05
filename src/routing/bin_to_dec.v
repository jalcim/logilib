`ifndef __BIN_TO_DEC__
 `define __BIN_TO_DEC__
 `include "src/primitive/gate/gate_or.v"

module bin_to_dec(in, addr);
   parameter SIZE = 2;
   localparam WAY = 2**SIZE;

   input [WAY-1:0] in;
   output [SIZE-1:0] addr;

   sub_bin_to_dec #(.SIZE(SIZE), .WAY(WAY)) inst(in, addr);
endmodule

module sub_bin_to_dec(in, addr);
   parameter SIZE = 2;
   parameter WAY = 2;
   
   gate_or #(.WAY(WAY-1), .WIRE(1)) or1();
   if (SIZE > 1)
     sub_bin_to_dec(in, addr);

endmodule
`endif
