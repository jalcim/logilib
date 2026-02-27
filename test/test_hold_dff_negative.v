`timescale 1ns/1ps

module serial_Dflipflop_delay2(D, clk, Q, QN);
   parameter WIRE = 1;
   parameter DELAY = 0.05;

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

module test_hold_dff_negative;
   reg clk, D;
   wire Q, QN;

   serial_Dflipflop_delay2 #(.WIRE(1), .DELAY(0.050)) dut (
      .D(D), .clk(clk), .Q(Q), .QN(QN)
   );

   initial begin
      $dumpfile("tmp/test_hold_dff_negative.vcd");
      $dumpvars(0, test_hold_dff_negative);
   end

   initial clk = 0;
   always #10 clk = ~clk;

   integer i;
   reg fail;

   initial begin
      fail = 0;
      D = 0;
      #100;

      // D change AVANT le front descendant (hold time negatif ?)
      // D=1 pendant clk=1, D->0 a X ps AVANT le front descendant
      $display("--- D change AVANT le front descendant ---");
      $display("avant_ps | Q | attendu | status");
      $display("---------|---|---------|-------");

      for (i = 0; i <= 500; i = i + 25) begin
         // Reset
         @(posedge clk); #1;
         D = 0;
         @(negedge clk); #1;

         // D=1 pendant clk=1
         @(posedge clk); #1;
         D = 1;

         // D->0 avant le front descendant
         // Front descendant a t=20ns, on change D a t=20-i ps
         // On est a posedge+1ns, front descendant dans 9ns
         // Changer D a (9 - i*0.001) ns apres maintenant
         if (i == 0) begin
            @(negedge clk); // D change au front exact
         end else begin
            #(9.0 - i * 0.001); // i ps avant le front
         end
         D = 0;

         @(negedge clk); // si pas deja passe
         #1;

         // Si D a change assez tot AVANT le front, le FF capture D=0
         // Si D a change juste avant, le FF devrait encore capturer D=1
         // La frontiere c'est le hold time (negatif = D peut changer AVANT)
         $display("   %4d  |  %b |    ?    | (D->0 %0dps avant front)", i, Q, i);
         if (i > 200 && Q !== 0) begin
            $display("         ^^^ D a change 200+ps avant, Q devrait etre 0");
         end
      end

      #20;
      $finish;
   end
endmodule
