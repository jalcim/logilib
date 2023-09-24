`ifndef __SERIAL_NOR__
 `define __SERIAL_NOR__

 `include "src/primitive/serial_gate/serial_or.v"

module serial_nor(out, e1);
   parameter BEHAVIORAL = 0;
   parameter WAY = 3;

   input [WAY-1:0] e1;
   output 	    out;

   if (BEHAVIORAL == 1)
     begin
	wire line;
	serial_or #(.WAY(WAY)) serial_or_inst(line, e1);
	not inst_not0(out, line);
     end
   else
     generate_serial_nor #(.BEHAVIORAL(BEHAVIORAL), .WAY(WAY)) generate_serial_nor_inst(out, e1);
endmodule

module generate_serial_nor(out, e1);
   parameter BEHAVIORAL = 1;
   parameter WAY       = 3;
   parameter N1         = (WAY / 2) + (WAY % 2);
   parameter N2         =  WAY / 2;

   input [WAY-1:0] e1;
   output 	    out;

   wire 	    W1, W2;

   if (WAY == 1)
     assign out = e1[0];

   else if (WAY == 2)
     begin
	if (BEHAVIORAL == 1)
	  or inst_or1  (out, e1[1], e1[0]);
	else
	  nor inst_nor1(out, e1[1], e1[0]);
     end

   else if (WAY > 2)
     begin
	if (BEHAVIORAL == 1)
	  or inst_or0  (out, W1, W2);
	else
	  nor inst_nor0(out, W1, W2);
	generate_serial_nor #(.WAY(N1)) recall1(W1, e1[WAY - 1 : WAY - N1]);
	generate_serial_nor #(.WAY(N2)) recall2(W2, e1[N2 - 1 : 0]);
     end
endmodule

`endif
