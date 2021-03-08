module recurse_mux(ctrl, in, out);

   parameter S = 3;//2^S
   parameter T = 1;

   input [(2 ** S) * T - 1:0] in;
   input [S - 1:0] 	ctrl;

   output [T-1:0] 	out;

   if (S == 1)
     begin
	assign out = ctrl ? in[2 * T - 1 : T] : in[T - 1 : 0];
     end
   else
     begin
	wire [T-1:0]out1, out2;

	recurse_mux #(.S(S - 1), .T(T)) mux1(.ctrl(ctrl[S - 2:0]), .in(in[(2 ** (S - 1)) * T - 1:0]), .out(out1));

	recurse_mux #(.S(S - 1), .T(T)) mux2(.ctrl(ctrl[S - 2:0]), .in(in[(2 ** S) * T - 1:(2 ** (S - 1)) * T]), .out(out2));

	assign out = ctrl[S - 1] ? out2 : out1;

     end // else: !if(S == 1)
endmodule
