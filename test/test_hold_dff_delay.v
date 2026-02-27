`timescale 1ns/1ps

// DFF avec delais de porte pour tester le hold time
module serial_Dflipflop_delay(D, clk, Q, QN);
   parameter WIRE = 1;
   parameter DELAY = 0.05; // 50ps par porte NOR

   input  clk;
   input  [WIRE-1:0] D;
   output [WIRE-1:0] Q, QN;

   wire [5:0] line;
   wire       line2;

   assign #DELAY line[0] = ~(line[3] | line[1]);
   assign #DELAY line[1] = ~(line[0] | clk);
   assign #DELAY line2   = ~(line[1] | clk | line[3]);
   assign #DELAY line[3] = ~(line2 | D[0]);

   assign #DELAY line[4] = ~(line[1] | line[5]);
   assign #DELAY line[5] = ~(line[4] | line2);

   assign Q[0]  = line[4];
   assign QN[0] = line[5];
endmodule

module test_hold_dff_delay;
   reg clk, D;
   wire Q, QN;

   serial_Dflipflop_delay #(.WIRE(1), .DELAY(0.050)) dut (
      .D(D), .clk(clk), .Q(Q), .QN(QN)
   );

   initial begin
      $dumpfile("tmp/test_hold_dff_delay.vcd");
      $dumpvars(0, test_hold_dff_delay);
   end

   initial clk = 0;
   always #10 clk = ~clk;

   integer i;
   reg [0:0] expected;
   reg fail;

   initial begin
      fail = 0;
      D = 0;
      #100; // laisser le circuit se stabiliser

      // Test fonctionnel de base
      @(posedge clk); #1;
      D = 1;
      @(negedge clk); #1; // attendre propagation
      $display("Fonctionnel: D=1 -> Q=%b (attendu 1)", Q);

      @(posedge clk); #1;
      D = 0;
      @(negedge clk); #1;
      $display("Fonctionnel: D=0 -> Q=%b (attendu 0)", Q);

      // Test hold : D=1 pendant clk=1, D change a 0 apres le front descendant
      // On varie le delai entre le front et le changement de D
      $display("\n--- Test hold time (D=1 pendant clk=1, D->0 apres front descendant) ---");
      $display("delai_ps | Q | attendu | status");
      $display("---------|---|---------|-------");

      for (i = 0; i <= 200; i = i + 10) begin
         // Mettre D=0 pour reset
         @(posedge clk); #1;
         D = 0;
         @(negedge clk); #1;

         // Mettre D=1
         @(posedge clk); #1;
         D = 1;
         // Attendre le front descendant, puis changer D apres i ps
         @(negedge clk);
         if (i > 0)
            #(i * 0.001); // convertir ps en ns
         D = 0;
         #1; // attendre propagation
         expected = 1;
         $display("   %4d  |  %b |    %b    | %s", i, Q, expected[0],
                  (Q === expected[0]) ? "OK" : "FAIL");
         if (Q !== expected[0]) fail = 1;
      end

      // Test inverse : D=0 pendant clk=1, D->1 apres front
      $display("\n--- Test hold time (D=0 pendant clk=1, D->1 apres front descendant) ---");
      $display("delai_ps | Q | attendu | status");
      $display("---------|---|---------|-------");

      for (i = 0; i <= 200; i = i + 10) begin
         @(posedge clk); #1;
         D = 1;
         @(negedge clk); #1;

         @(posedge clk); #1;
         D = 0;
         @(negedge clk);
         if (i > 0)
            #(i * 0.001);
         D = 1;
         #1;
         expected = 0;
         $display("   %4d  |  %b |    %b    | %s", i, Q, expected[0],
                  (Q === expected[0]) ? "OK" : "FAIL");
         if (Q !== expected[0]) fail = 1;
      end

      if (fail)
         $display("\n*** HOLD VIOLATION DETECTED ***");
      else
         $display("\n*** ALL TESTS PASSED (hold time < 0ps avec %0.0fps gate delay) ***", 50.0);

      #20;
      $finish;
   end
endmodule
