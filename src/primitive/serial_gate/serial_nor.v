`ifndef __SERIAL_NOR__
 `define __SERIAL_NOR__

module serial_nor(out, e1);
   parameter BEHAVIORAL = 0;
   parameter WIRE = 3;

   input [WIRE-1:0] e1;
   output 	    out;

   wire		    line;
   
   generate_serial_nor #(.BEHAVIORAL(BEHAVIORAL), .WIRE(WIRE)) generate_serial_nor_inst(line, e1);
   if (BEHAVIORAL == 1)
     not inst_not0(out, line);
   else
     assign out = line;   
endmodule

module generate_serial_nor(out, e1);
   parameter BEHAVIORAL = 0;
   parameter WIRE       = 3;
   parameter N1         = (WIRE / 2) + (WIRE % 2);
   parameter N2         =  WIRE / 2;

   input [WIRE-1:0] e1;
   output 	    out;

   wire 	    W1, W2;

   if (WIRE == 1)
     assign out = e1[0];

   else if (WIRE == 2)
     begin
	if (BEHAVIORAL == 1)
	  or inst_or1  (out, e1[1], e1[0]);
	else
	  nor inst_nor1(out, e1[1], e1[0]);
     end

   else if (WIRE > 2)
     begin
	if (BEHAVIORAL == 1)
	  or inst_or0  (out, W1, W2);
	else
	  nor inst_nor0(out, W1, W2);
	generate_serial_nor #(.WIRE(N1)) recall1(W1, e1[WIRE - 1 : WIRE - N1]);
	generate_serial_nor #(.WIRE(N2)) recall2(W2, e1[N2 - 1 : 0]);
     end
endmodule

`endif
