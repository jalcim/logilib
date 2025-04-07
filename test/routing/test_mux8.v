`include "src/routing/mux.v"

module test_mux8;
   parameter WAY = 8;
   parameter WIRE = 1;

   localparam SIZE_IN   = WAY * WIRE;
   localparam SIZE_CTRL = 3; // log2(8)=3

   reg [SIZE_IN-1:0] in;
   reg [SIZE_CTRL-1:0] ctrl;
   wire [WIRE-1:0] out;

   integer i;

   // Instanciation du multiplexeur
   mux #(.WAY(WAY), .WIRE(WIRE)) mux0(.ctrl(ctrl), .in(in), .out(out));

   initial begin
      $dumpfile("signal_mux8.vcd");
      $dumpvars(0, test_mux8);

      // Remplissage de 'in' avec un motif simple (alternance 0/1) pour chaque voie
      for (i = 0; i < WAY; i = i + 1) begin
         in[i*WIRE +: WIRE] = i % 2;
      end
      
      $display("Time\tCTRL\tIN\t\tOUT");
      // Parcours de toutes les valeurs possibles du signal de contrôle
      for (i = 0; i < (1 << SIZE_CTRL); i = i + 1) begin
         ctrl = i;
         #5;
         $display("%0t\t%b\t%b\t%b", $time, ctrl, in, out);
      end

      $finish;
   end
endmodule
