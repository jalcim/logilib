module serial_and(out, e1);
   parameter SIZE = 6;
   parameter N1 = (SIZE / 2) + (SIZE % 2);
   parameter N2 = SIZE / 2;
   parameter STAGE = SIZE / 2;

   input [SIZE-1:0] e1;
   output 	    out;

   wire 	    W1, W2;

   if (SIZE == 1)
     begin
	buf buf1(out, e1[0]);
     end
   else if (SIZE == 2)
     begin
	if (STAGE > 1)
	  begin
	     buf buf2(out,  W1);
	     serial_and #(.SIZE(SIZE), .STAGE(STAGE-1)) recall3(W1, e1[1 : 0]);
	  end
	else
	  begin
	     and and1(out, e1[0], e1[1]);
	  end
     end
   else if (SIZE > 2)
     begin
	and and0(out, W1, W2);
	serial_and #(.SIZE(N1), .STAGE(STAGE-1)) recall1(W1, e1[SIZE - 1 : SIZE - N1]);
	serial_and #(.SIZE(N2), .STAGE(STAGE-1)) recall2(W2, e1[N2 - 1 : 0]);
     end

endmodule
