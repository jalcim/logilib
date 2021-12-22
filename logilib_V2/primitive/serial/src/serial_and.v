module serial_and(out, e1);
   parameter SIZE = 8;
   parameter N1 = (SIZE / 2) + (SIZE % 2);
   parameter N2 = SIZE / 2;

   input [SIZE-1:0] e1;
   output 	    out;

   wire 	    W1, W2;

   if (SIZE == 2)
     begin
	
     end
   else if (SIZE > 3)
     begin
	and and0(out, W1, W2);
	serial #(.SIZE(N1)) recall1(W1, e1[SIZE - 1 : SIZE - N1]);
	serial #(.SIZE(N2)) recall2(W2, e1[N2 - 1 : 0]);
     end
   else
     begin
	assign out = e1;
     end

endmodule
