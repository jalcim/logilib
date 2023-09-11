`ifndef __SERIAL_XOR__
 `define __SERIAL_XOR__

module serial_xor(out, e1);
   parameter WIRE = 3;
   parameter N1 = (WIRE / 2) + (WIRE % 2);
   parameter N2 = WIRE / 2;

   input [WIRE-1:0] e1;
   output 	    out;

   wire 	    W1, W2;

   if (WIRE == 1)
     assign out = e1[0];

   else if (WIRE == 2)
     xor xor1(out, e1[0], e1[1]);

   else if (WIRE > 2)
     begin
	xor xor0(out, W1, W2);
	serial_xor #(.WIRE(N1)) recall1(W1, e1[WIRE - 1 : WIRE - N1]);
	serial_xor #(.WIRE(N2)) recall2(W2, e1[N2 - 1 : 0]);
     end
endmodule

`endif
