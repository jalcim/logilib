module replicator(in, out);
   parameter WIRE = 3;
   parameter WAY = 2;

   input  [2**WIRE-1:0] in;              //7:0
   output [(2**WAY)*(2**WIRE) -1:0] out;//31:0

   if (WAY == 1)
     begin
	recursive_buf #(.S(WIRE))buf_replicator0(in[2**WIRE-1:0],                 //7:0
						 out[2**(WIRE)-1  :0]);          //(2**3)-1 = 7:0
	recursive_buf #(.S(WIRE))buf_replicator1(in[2**WIRE-1:0],               //7:0
						 out[2**(WIRE+1)-1:2**(WIRE)]);//(2**4)-1   = 15:8
     end
   else
     begin
	replicator #(.WIRE(WIRE), .WAY(WAY-1)) replicator0(in[2**WIRE-1:0],                     //7:0
							   out[2**((WAY-1)+WIRE) -1:0]);//2**(1+3) -1 = (15):0

	replicator #(.WIRE(WIRE), .WAY(WAY-1)) replicator1(in[2**WIRE-1:0],                 //7:0
							   out[2** (WAY+WIRE) -1://2**(2+3) -1 = (31):16
							       2**((WAY-1)+WIRE)]);//2**(1+3)     =  31:(16)
     end
endmodule // replicator

module fragmented_replicator(in, out);
   parameter WIRE = 3;
   parameter WAY = 1;
   parameter BUS = 1;

   input  [2**(BUS+WIRE) -1:0] 	  in;
   output [2**(BUS+WAY+WIRE) -1:0] out;
   
   if (BUS == 1)
     begin
	replicator #(.WIRE(WIRE), .WAY(WAY)) replicator0(in[2**((BUS-1)+WIRE)-1:0],                      //7:0
							   out[2**((BUS-1)+WAY+WIRE) -1:0]);//2**(0+1+3) -1 = (15):0
	
	replicator #(.WIRE(WIRE), .WAY(WAY)) replicator1(in[2**(BUS+WIRE)-1:2**((BUS-1)+WIRE)],          //15:8
							   out[2**(BUS+WAY+WIRE) -1:   //2**(1+1+3) -1 = (31):16
							       2**((BUS-1)+WAY+WIRE)]);//2**(0+1+3)    =  31:(16)
     end
   else
     begin
	fragmented_replicator #(.WIRE(WIRE), .WAY(WAY), .BUS(BUS-1))fragmented_replicator0(in[ 2**((BUS-1)+WIRE) -1:0],  //(4*8-1):0    = 31:0
											   out[2**((BUS-1)+WAY+WIRE) -1:0]);//(4*4*8-1):(0) = 127:0

	
	fragmented_replicator #(.WIRE(WIRE), .WAY(WAY), .BUS(BUS-1))fragmented_replicator1(in[2**(BUS+WIRE) -1:2**((BUS-1)+WIRE)],//(8*8-1):(4*8)= 63:32
											   out[2**(BUS+WAY+WIRE) -1://(8*4*8-1):
											       2**((BUS-1)+WAY+WIRE)]);//(4*4*8)      = 255:128
     end
endmodule // fragmented_replicator
