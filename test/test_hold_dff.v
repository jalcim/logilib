`timescale 1ns/1ps

`include "src/memory/dflipflop/serial/serial_Dflipflop.v"

module test_hold_dff;
   reg clk, D;
   wire Q, QN;

   serial_Dflipflop #(.WIRE(1)) dut (
      .D(D),
      .clk(clk),
      .Q(Q),
      .QN(QN)
   );

   initial begin
      $dumpfile("tmp/test_hold_dff.vcd");
      $dumpvars(0, test_hold_dff);
   end

   // Clock 50 MHz : periode 20ns
   initial clk = 0;
   always #10 clk = ~clk;

   initial begin
      D = 0;

      // --- Test 1 : fonctionnement normal ---
      // Capture sur front descendant (clk 1->0)
      @(posedge clk); #1;
      D = 1;              // D=1 pendant clk=1
      @(negedge clk); #2; // apres front descendant, Q devrait etre 1
      $display("T1: D=1 stable pendant clk=1 -> Q=%b (attendu 1)", Q);

      @(posedge clk); #1;
      D = 0;              // D=0 pendant clk=1
      @(negedge clk); #2;
      $display("T2: D=0 stable pendant clk=1 -> Q=%b (attendu 0)", Q);

      // --- Test 2 : hold time - D change AU MOMENT du front descendant ---
      @(posedge clk); #1;
      D = 1;              // D=1 pendant clk=1
      @(negedge clk);     // front descendant exact
      #0 D = 0;           // D change a 0 au meme instant
      #2;
      $display("T3: D=1->0 au front descendant exact -> Q=%b (attendu 1 si hold OK)", Q);

      // --- Test 3 : D change 100ps apres front descendant ---
      @(posedge clk); #1;
      D = 1;
      @(negedge clk);
      #0.1 D = 0;         // 100ps apres le front
      #2;
      $display("T4: D=1->0 a 100ps apres front -> Q=%b (attendu 1)", Q);

      // --- Test 4 : D change 50ps apres front descendant ---
      @(posedge clk); #1;
      D = 1;
      @(negedge clk);
      #0.05 D = 0;        // 50ps apres le front
      #2;
      $display("T5: D=1->0 a 50ps apres front -> Q=%b (attendu 1)", Q);

      // --- Test 5 : D change 10ps apres front descendant ---
      @(posedge clk); #1;
      D = 1;
      @(negedge clk);
      #0.01 D = 0;        // 10ps apres le front
      #2;
      $display("T6: D=1->0 a 10ps apres front -> Q=%b (attendu 1)", Q);

      // --- Test 6 : D change 1ps apres front descendant ---
      @(posedge clk); #1;
      D = 1;
      @(negedge clk);
      #0.001 D = 0;       // 1ps apres le front
      #2;
      $display("T7: D=1->0 a 1ps apres front -> Q=%b (attendu 1)", Q);

      // --- Test 7 : inverse - verifier que D=0 est capture ---
      @(posedge clk); #1;
      D = 0;
      @(negedge clk); #2;
      $display("T8: D=0 stable -> Q=%b (attendu 0)", Q);

      // --- Test 8 : D change AVANT le front (pendant clk=1) ---
      @(posedge clk); #1;
      D = 1;
      #5;                 // D=1 pendant 5ns
      D = 0;              // D revient a 0 avant le front descendant
      @(negedge clk); #2;
      $display("T9: D=1 puis 0 avant front -> Q=%b (attendu 0, derniere valeur)", Q);

      #20;
      $finish;
   end

endmodule
