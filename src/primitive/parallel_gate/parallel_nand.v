`ifndef __PARALLEL_NAND__
 `define __PARALLEL_NAND__

 `include "src/primitive/serial_gate/serial_nand.v"

module parallel_nand(out, in);
   parameter BEHAVIORAL = 0;
   parameter WAY = 2;
   parameter WIRE = 2;

   localparam SIZE = WAY * WIRE;
   input  [SIZE-1 : 0] in;
   output [WIRE-1 : 0] out;//1 output par WIRE

   //on traite WAY input de 1 fil a la fois
   serial_nand #(.BEHAVIORAL(BEHAVIORAL), .WAY(WAY)) nand1(out[0], in[WAY-1:0]);
   if (WIRE > 1)
     //le nombre de WIRE par input indique combien de portes sont en parallele
     //on decremente WIRE de 1, car 1 fil par input a ete traiter
     //la prochaine "recursion" aura donc 1 sortie de moins et WAY fil  de moins
     parallel_nand #(.BEHAVIORAL(BEHAVIORAL), .WAY(WAY) , .WIRE(WIRE-1)) parallel_nand0(out[WIRE-1:1],
											in[SIZE-1 : WAY]);
endmodule

`endif
