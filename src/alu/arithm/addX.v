`ifndef __ADDX__
 `define __ADDX__

 `include "src/alu/arithm/add.v"

module addX (a, b, cin, out, cout);
   parameter WIRE = 8;

   input [WIRE-1:0] a, b;
   input 	    cin;

   output [WIRE-1:0] out;
   output 	     cout;

   wire 	     ret;

   if (WIRE > 1)
     begin
	add add0 (a[0], b[0], cin, out[0], ret);
	addX #(.WIRE(WIRE-1)) recall(a[WIRE-1:1],
				     b[WIRE-1:1],
				     ret,
				     out[WIRE-1:1],
				     cout);
     end
   else
     add add0 (a[0], b[0], cin, out[0], cout);
endmodule

`endif
