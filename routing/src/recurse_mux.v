module recurse_mux(ctrl, in, out);

   parameter S = 3;//2^S
   parameter T = 8;

   input [(2**S) * T - 1:0] in;  //7:0
   input [S - 1:0] 	      ctrl;//2:0

   output [T-1:0] 	      out;//0:0

   if (S == 1)
     begin
	assign out = ctrl ? in[2 * T - 1 : T] : in[T - 1 : 0]; //1:1 & 0:0
     end
   else
     begin
	wire [T-1:0]out1, out2;//0:0

	recurse_mux #(.S(S - 1), .T(T)) mux1(.ctrl(ctrl[S - 2:0]),                        //1:0
					     .in(in[(2 ** (S - 1)) * T - 1:0]),           //3:0
					     .out(out1));

	recurse_mux #(.S(S - 1), .T(T)) mux2(.ctrl(ctrl[S - 2:0]),                        //1:0
					     .in(in[(2 ** S) * T - 1:(2 ** (S - 1)) * T]),//7:4
					     .out(out2));

	assign out = ctrl[S - 1] ? out2 : out1;//[2]

     end
endmodule
