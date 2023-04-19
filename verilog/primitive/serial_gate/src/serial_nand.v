module serial_nand(out, e1);
   parameter SIZE = 3;
   parameter N1 = (SIZE / 2) + (SIZE % 2);
   parameter N2 = SIZE / 2;

   input [SIZE-1:0] e1;
   output 	    out;

   wire 	    W1, W2, W3;

   if (SIZE == 1)
     begin
	assign out = e1[0];
     end
   else if (SIZE == 2)
     begin
	and and0(out, e1[0], e1[1]);
     end
   else if (SIZE > 2)
     begin
	and and0(W3, W1, W2);
	serial_nand #(.SIZE(N1)) recall1(W1, e1[SIZE - 1 : SIZE - N1]);
	serial_nand #(.SIZE(N2)) recall2(W2, e1[N2 - 1 : 0]);
     end
   not shame(out, W3);
endmodule
