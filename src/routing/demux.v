`ifndef __DEMUX__
 `define __DEMUX__

module demux(ctrl, in, out);
   parameter S = 1;//2^S//nombre de sortie
   parameter T = 1;//taille des sorties

   localparam NB_OUT = 2 ** S;
   localparam SIZE_OUT = NB_OUT * T;

   localparam NEXT_S = S-1;
   localparam NEXT_SIZE_OUT = 2 ** (S-1) * T;

   input [T-1:0] in;//0:0
   input [S-1:0] ctrl;//2:0

   output [SIZE_OUT - 1:0] out; //7:0

   if (S == 1)
     begin
	assign out[T - 1 : 0]     = ~ctrl ? in : 0;//0:0//t==2 ? 1:0
	assign out[2 * T - 1 : T] =  ctrl ? in : 0;//1:1//t==2 ? 3:2
     end
   else
     begin
	wire [NEXT_SIZE_OUT - 1:0]out1, out2;//3:0

	demux #(.S(S-1), .T(T)) mux1(ctrl[S - 2:0],//1:0
				     in,           //3:0
				     out1);

	demux #(.S(S-1), .T(T)) mux2(ctrl[S - 2:0],//1:0
				     in,           //7:4
				     out2);

	assign out[NEXT_SIZE_OUT - 1:0]        = ~ctrl[S-1] ? out1 : 0;//3:0
	assign out[SIZE_OUT - 1:NEXT_SIZE_OUT] =  ctrl[S-1] ? out2 : 0;//7:4
     end
endmodule

`endif
