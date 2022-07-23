/*
 GATE :
 2 = and;
 3 = nand;
 4 = or;
 5 = nor;
 6 = xor;
 7 = xnor;
 */
module multi_gate(out, e1);
   parameter GATE = 2;
   parameter SIZE = 6;
   parameter N1 = (SIZE / 2) + (SIZE % 2);
   parameter N2 = SIZE / 2;

   input [SIZE-1:0] e1;
   output 	    out;

   wire 	    W1, W2, W3;
   wire 	    size2, more2;
   
   if (SIZE == 1)
     begin
	assign out = e1[0];
     end
   else if (SIZE == 2)
     begin
	if (GATE == 2 || GATE == 3)
	  and and1(out, e1[0], e1[1]);
	else if (GATE == 4)
	  or or1(out, e1[0], e1[1]);
	else if (GATE == 5)
	  nor nor1(out, e1[0], e1[1]);
	else if (GATE == 6)
	  xor xor1(out, e1[0], e1[1]);
	else if (GATE == 7)
	  xnor xnor1(out, e1[0], e1[1]);
     end
   else if (SIZE > 2)
     begin
	if (GATE == 2)
	  and and0(out, W1, W2);
	else if (GATE == 3)
	  begin
	     and and0(W3, W1, W2);
	     not shame(out, W3);
	  end
	else if (GATE == 4)
	  or or0(out, W1, W2);
	else if (GATE == 5)
	  nor nor0(out, W1, W2);
	else if (GATE == 6)
	  xor xor0(out, W1, W2);
	else if (GATE == 7)
	  xnor xnor0(out, W1, W2);

	multi_gate #(.GATE(GATE), .SIZE(N1)) recall1(W1, e1[SIZE - 1 : SIZE - N1]);
	multi_gate #(.GATE(GATE), .SIZE(N2)) recall2(W2, e1[N2 - 1 : 0]);
     end
endmodule

/*
    if ((GATE == 2 || GATE == 3) && SIZE == 2)
     begin
	and and1(out, e1[0], e1[1]);
     end
   else if (GATE == 4 && SIZE == 2)
     or or1(W3, e1[0], e1[1]);
   else if (GATE == 5 && SIZE == 2)
     nor nor1(W3, e1[0], e1[1]);
   else if (GATE == 6 && SIZE == 2)
     xor xor1(W3, e1[0], e1[1]);
   else if (GATE == 7 && SIZE == 2)
     xnor xnor1(W3, e1[0], e1[1]);

 
 
    if ((GATE == 2 || GATE == 3) && SIZE > 2)
     and and0(W3, W1, W2);
   else if (GATE == 4 && SIZE > 2)
     or or0(W3, W1, W2);
   else if (GATE == 5 && SIZE > 2)
     nor nor0(W3, W1, W2);
   else if (GATE == 6 && SIZE > 2)
     xor xor0(out, W1, W2);
   else if (GATE == 7 && SIZE > 2)
     xnor xnor0(W3, W1, W2);
 */
