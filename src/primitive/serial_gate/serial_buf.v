`ifndef __SERIAL_BUF__
 `define __SERIAL_BUF__

module serial_buf(out, in);
   parameter SIZE = 3;
   localparam N1 = (SIZE / 2) + (SIZE % 2); //1+1 = 2
   localparam N2 = SIZE / 2;                //    = 1

   input  in;
   output [SIZE-1 : 0] out;

   wire 	       l1, l2;

   if (SIZE == 1)
     assign out = in;
   else if (SIZE > 1)
     begin
	buf buf1(l1, in);
	buf buf2(l2, in);
	serial_buf #(.SIZE(N1)) recall1(out[N1-1:0], l1);   //1:0 = 2bit
	serial_buf #(.SIZE(N2)) recall2(out[SIZE-1:N1], l2);//2:2 = 1bit
     end
endmodule

`endif
