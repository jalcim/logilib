`ifndef __SERIAL_AND__
 `define __SERIAL_AND__

module serial_and(out, e1);
   parameter SIZE = 3;
   parameter N1 = (SIZE / 2) + (SIZE % 2);
   parameter N2 = SIZE / 2;

   input [SIZE-1:0] e1;
   output 	    out;

   wire 	    W1, W2;

   if (SIZE == 1)
     assign out = e1[0];

   else if (SIZE == 2)
     and and1(out, e1[0], e1[1]);

   else if (SIZE > 2)
     begin
	and and0(out, W1, W2);
	serial_and #(.SIZE(N1)) recall1(W1, e1[SIZE - 1 : SIZE - N1]);
	serial_and #(.SIZE(N2)) recall2(W2, e1[N2 - 1 : 0]);
     end
endmodule

`endif
