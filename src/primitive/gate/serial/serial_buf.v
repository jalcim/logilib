/*
`ifndef __SERIAL_BUF__
 `define __SERIAL_BUF__

module serial_buf(out, in);
   parameter WIRE = 3;
   localparam N1 = (WIRE / 2) + (WIRE % 2); //1+1 = 2
   localparam N2 = WIRE / 2;                //    = 1

   input  in;
   output [WIRE-1 : 0] out;

   wire 	       l1, l2;

   if (WIRE == 1)
     assign out = in;
   else if (WIRE > 1)
     begin
	buf buf1(l1, in);
	buf buf2(l2, in);
	serial_buf #(.WIRE(N1)) recall1(out[N1-1:0], l1);   //1:0 = 2bit
	serial_buf #(.WIRE(N2)) recall2(out[WIRE-1:N1], l2);//2:2 = 1bit
     end
endmodule

`endif
*/
