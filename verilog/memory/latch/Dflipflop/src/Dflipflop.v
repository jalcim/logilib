module Dflipflop(set, data, clk, reset, s1, s2);
   input set, data, clk;
   output s1, s2;

   wire [19:0] line;

   assign line[0] = ~(set     & line[3] & line[1]);
   assign line[1] = ~(line[0] & clk     & reset  );
   assign line[2] = ~(line[1] & clk     & line[3]);
   assign line[3] = ~(line[2] & data    & reset  );
   assign line[4] = ~(set     & line[1] & line[5]);
   assign line[5] = ~(line[4] & line[2] & reset  );

endmodule
  
