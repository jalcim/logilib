`ifndef __REPLICATOR__
 `define __REPLICATOR__

 `include "src/primitive/gate/gate_buf.v"

module replicator(out, in);
   parameter WAY = 8;
   parameter WIRE = 1;
   
   localparam SIZE = WAY * WIRE;
   localparam N1 = (WAY / 2) + (WAY % 2); //1+1 = 2
   localparam N2 = WAY / 2;               //    = 1
   localparam NSIZE = N1 * WIRE;

   input [WIRE-1:0] in;
   output [SIZE-1:0] out;

   wire [WIRE-1:0]   l1, l2;

   if (WAY == 1)
     assign out = in;
   else if (WAY > 1)
     begin
	gate_buf #(.WIRE(WIRE)) buf_inst1(l1, in);
	gate_buf #(.WIRE(WIRE)) buf_inst2(l2, in);
	replicator #(.WAY(N1), .WIRE(WIRE)) recall1(out[NSIZE-1:0], l1);   //1:0 = 2bit
	replicator #(.WAY(N2), .WIRE(WIRE)) recall2(out[SIZE-1:NSIZE], l2);//2:2 = 1bit
     end
endmodule
   
`endif

//deprecated

/*module replicator(out, in);
   parameter WIRE = 8;
   parameter WAY = 4;
   parameter SIZE = WAY * WIRE;

   input  [WIRE-1:0] in;              //7:0
   output [SIZE-1:0] out;             //31:0

   recursive_buf #(.S(WIRE))buf_replicator0(out[WIRE-1:0],                 //7:0
					    in [WIRE-1:0]);
   if (WAY > 1)
     replicator #(.WIRE(WIRE), .WAY(WAY-1)) recall(out[SIZE-1:WIRE],
						   in [SIZE-1:0]);
endmodule
*/
/*
module replicator(in, out);
   parameter WIRE = 3;
   parameter WAY = 1;

   input  [2**WIRE-1:0] in;              //7:0
   output [(2**WAY)*(2**WIRE) -1:0] out;//31:0

   if (WAY == 1)
     begin
	parallel_buf #(.S(2**WIRE))buf_replicator0(in[2**WIRE-1:0],                 //7:0
						 out[2**(WIRE)-1  :0]);          //(2**3)-1 = 7:0
	parallel_buf #(.S(2**WIRE))buf_replicator1(in[2**WIRE-1:0],               //7:0
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
*/
