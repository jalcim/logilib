`timescale 1ns/1ps

`include "src/primitive/gate/multi/multi_or.v"

module test_multi_or;

  parameter NB_GATE = 4;
  parameter WAY = 8;

  reg [(NB_GATE*WAY)-1:0] converged;
  wire [NB_GATE-1:0] addr;

  multi_or #(.NB_GATE(NB_GATE), .WAY(WAY)) uut (
    .converged(converged),
    .addr(addr)
  );

  initial begin
    $monitor("Time=%0t | converged=%b | addr=%b", $time, converged, addr);

    // Test 1: Tous à zéro
    converged = 0;
    #10;

    // Test 2: Un seul bit actif sur chaque groupe WAY
    converged = {8'b00000001, 8'b00000010, 8'b00000100, 8'b00001000};
    #10;

    // Test 3: Plusieurs bits actifs
    converged = {8'b11111111, 8'b00000000, 8'b10101010, 8'b01010101};
    #10;

    // Test 4: Tous à 1
    converged = {NB_GATE*WAY{1'b1}};
    #10;

    // Test 5: Pattern aléatoire
    converged = $random;
    #10;

    $finish;
  end
endmodule
