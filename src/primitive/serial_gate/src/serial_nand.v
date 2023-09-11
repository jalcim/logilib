`ifndef __SERIAL_NAND__
 `define __SERIAL_NAND__

module serial_nand(out, e1);
   parameter WIRE = 3;
   parameter N1 = (WIRE / 2) + (WIRE % 2);
   parameter N2 = WIRE / 2;

   input [WIRE-1:0] e1;
   output 	    out;

   wire 	    W1, W2;

   if (WIRE == 1)
     assign out = e1[0];

   else if (WIRE == 2)
     nand nand1(out, e1[0], e1[1]);

   else if (WIRE > 2)
     begin
	nand nand0(out, W1, W2);
	serial_nand #(.WIRE(N1)) recall1(W1, e1[WIRE - 1 : WIRE - N1]);
	serial_nand #(.WIRE(N2)) recall2(W2, e1[N2 - 1 : 0]);
     end
endmodule

`endif
