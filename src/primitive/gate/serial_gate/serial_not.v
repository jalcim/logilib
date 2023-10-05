/*
`ifndef __SERIAL_NOT__
 `define __SERIAL_NOT__

module serial_not(out, in);
   parameter WIRE = 3;
   parameter N1 = (WIRE / 2) + (WIRE % 2); //1+1 = 2
   parameter N2 = WIRE / 2;                //    = 1

   input  in;
   output [WIRE-1 : 0] out;

   wire 	       l1, l2;

   if (WIRE == 1)
     assign out = in;
   else if (WIRE > 1)
     begin
	not not1(l1, in);
	not not2(l2, in);
	serial_not #(.WIRE(N1)) recall1(out[N1-1:0], l1);   //1:0 = 2bit
	serial_not #(.WIRE(N2)) recall2(out[WIRE-1:N1], l2);//2:2 = 1bit
     end
endmodule

`endif
*/
