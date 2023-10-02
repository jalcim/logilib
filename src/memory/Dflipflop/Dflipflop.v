`ifndef __DFLIPFLOP__
 `define __DFLIPFLOP__

module Dflipflop(preset, data, clk, clear, Q, QN);
   input clear, data, clk, preset;
   output Q, QN;

   wire [5:0] line;

   assign line[0] = ~(clear   | line[3] | line[1]);
   assign line[1] = ~(line[0] | clk     | preset  );
   assign line[2] = ~(line[1] | clk     | line[3]);
   assign line[3] = ~(line[2] | data    | preset  );

   assign line[4] = ~(clear   | line[1] | line[5]);
   assign line[5] = ~(line[4] | line[2] | preset  );

   assign Q = line[4];
   assign QN = line[5];
endmodule

`endif
