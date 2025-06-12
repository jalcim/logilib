`ifndef __BRU__
 `define __BRU__

module bru(in, funct3, SIGNAL_bru, SIGNAL_pc);
   input [31:0] in;
   input [2:0]	funct3;
   input	SIGNAL_bru;
   output	SIGNAL_pc;

   wire		out_bru;
   wire		beq, bne, blt, bge;

   assign beq = in == 0;
   assign bne = in != 0;
   assign blt = in[31] == 1;
   assign bge = (in[31] == 1'b0) && (|in[30:0]);

   assign out_bru = funct3[2] ?
		    funct3[0] ? bge : blt
		    :
		    funct3[0] ? bne : beq;

   assign SIGNAL_pc = SIGNAL_bru & out_bru;
endmodule

`endif
   /*
    beq 000 ==      == 0
    bne 001 !=      != 0
    blt 100 <       [31] == 1
    bge 101 >       [31] == 0 && [30:0];
  //bltu 110 <      [31] == 1
  //bgeu 111 >      [31] == 0 && [30:0];
    */

//   assign one  = funct3[0] ? (bne | bge | bgeu) : (beq | blt | bltu);
//   assign two  = funct3[1] ? (bltu | bgeu) : ;
//   assign tree = funct3[2] ? bltu | bgeu | blt | bge : beq | bne;

