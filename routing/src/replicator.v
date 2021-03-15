module replicator(in, out);
   parameter WIRE = 3;
   parameter WAY  = 2;

   input  [2**WIRE-1:0] in;
   output [(2**WAY)*(2**WIRE) -1:0] out;

   if (WAY == 1)
     begin
	recursive_buf #(.S(WIRE))buf_replicator0(in [7:0], out[2**(WIRE)-1  :0]);        //(2**3)-1 = 7:0
	recursive_buf #(.S(WIRE))buf_replicator1(in [7:0], out[2**(WIRE+1)-1:2**(WIRE)]);//(2**4)-1 = 15:8
     end
   else
     begin
	replicator #(.WIRE(WIRE), .WAY(WAY-1)) replicator0(in, out[(2**(WAY-1))*(2**WIRE) -1:0]);//(2**1) * (2**3) -1 = (15):0
	replicator #(.WIRE(WIRE), .WAY(WAY-1)) replicator1(in, out[(2** WAY)   *(2**WIRE) -1:    //(2**2) * (2**3) -1 = (31):16
								   (2**(WAY-1))*(2**WIRE)]);     //(2**1) * (2**3)    =  31:(16)
     end
endmodule // replicator

