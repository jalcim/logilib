`ifndef __SERIAL_AND__
 `define __SERIAL_AND__

module serial_and(out, e1);
   parameter WAY = 3;
   parameter N1 = (WAY / 2) + (WAY % 2);
   parameter N2 = WAY / 2;

   input [WAY-1:0] e1;
   output 	    out;

   wire 	    W1, W2;

   if (WAY == 1)
     assign out = e1[0];

   else if (WAY == 2)
     and and1(out, e1[0], e1[1]);

   else if (WAY > 2)
     begin
	and and0(out, W1, W2);
	serial_and #(.WAY(N1)) recall1(W1, e1[WAY - 1 : WAY - N1]);
	serial_and #(.WAY(N2)) recall2(W2, e1[N2 - 1 : 0]);
     end
endmodule

`endif
