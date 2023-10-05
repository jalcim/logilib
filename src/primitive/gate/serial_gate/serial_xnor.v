`ifndef __SERIAL_XNOR__
 `define __SERIAL_XNOR__

 `include "src/primitive/serial_gate/serial_xor.v"

module serial_xnor(out, e1);
   parameter BEHAVIORAL = 1;
   parameter WAY = 3;//nombre d'input (pour cette gate)

   input [WAY-1:0] e1;
   output 	    out;

   if (BEHAVIORAL == 1)
     begin
	wire line;
	serial_xor #(.WAY(WAY)) serial_and_inst(line, e1);
	not inst_not0(out, line);
     end
   else
     generate_serial_xnor #(.BEHAVIORAL(BEHAVIORAL), .WAY(WAY)) generate_serial_xnor_inst(out, e1);
endmodule

module generate_serial_xnor(out, e1);
   parameter BEHAVIORAL = 0;
   parameter WAY       = 3;
   parameter N1         = (WAY / 2) + (WAY % 2);
   parameter N2         =  WAY / 2;

   input [WAY-1:0] e1;
   output 	    out;

   wire 	    W1, W2;

   if (WAY == 1)//nombre d'input insuffisant (sera traiter a l'etage du dessus)
     assign out = e1[0];

   else if (WAY == 2)//une gate a 2 input standard
     xnor inst_xnor1(out, e1[1], e1[0]);

   else if (WAY > 2)//si plus de 2 input une recursion est necessaire
     begin
	xnor inst_xnor0(out, W1, W2);
	generate_serial_xnor #(.WAY(N1)) recall1(W1, e1[WAY - 1 : WAY - N1]);
	generate_serial_xnor #(.WAY(N2)) recall2(W2, e1[N2 - 1   : 0]);
     end
endmodule

`endif
