`ifndef __SERIAL_XNOR__
 `define __SERIAL_XNOR__

module serial_xnor(out, e1);
   parameter WIRE = 3;
   parameter N1 = (WIRE / 2) + (WIRE % 2);
   parameter N2 = WIRE / 2;

   input [WIRE-1:0] e1;
   output 	    out;

   wire 	    W1, W2;

   if (WIRE == 1)
     assign out = e1[0];

   else if (WIRE == 2)
     xnor xnor1(out, e1[0], e1[1]);

   else if (WIRE > 2)
     begin
	xnor xnor0(out, W1, W2);
	serial_xnor #(.WIRE(N1)) recall1(W1, e1[WIRE - 1 : WIRE - N1]);
	serial_xnor #(.WIRE(N2)) recall2(W2, e1[N2 - 1 : 0]);
     end
endmodule

`endif
