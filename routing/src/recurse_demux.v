module recurse_demux(ctrl, in, out);

   parameter S = 3;//2^S
   parameter T = 1;

   input [T-1:0] in;//0:0
   input [S - 1:0] ctrl;//2:0

   output [(2 ** S) * T - 1:0] out; //7:0

   if (S == 1)
     begin
	assign out[T - 1 : 0]     = ~ctrl ? in : 0;//0:0
	assign out[2 * T - 1 : T] =  ctrl ? in : 0;//1:1
     end
   else
     begin
	wire [(2 ** (S-1)) * T - 1:0]out1, out2;//3:0

	recurse_demux #(.S(S - 1), .T(T)) mux1(.ctrl(ctrl[S - 2:0]),//1:0
					     .in(in),               //3:0
					     .out(out1));

	recurse_demux #(.S(S - 1), .T(T)) mux2(.ctrl(ctrl[S - 2:0]),//1:0
					     .in(in),               //7:4
					     .out(out2));

	assign out[(2 ** (S - 1)) * T - 1:0]            = ~ctrl[S-1] ? out1 : 0;//3:0
	assign out[(2 ** S) * T - 1:(2 ** (S - 1)) * T] =  ctrl[S-1] ? out2 : 0;//7:4

     end
endmodule
