module recurse_mux(z, d, s);

   parameter S = 3;//2^S
   parameter T = 1;

   output [T-1:0] z;

   input [(2 ** S) * T - 1:0] d;
   input [S - 1:0] 	s;

   if (S == 1)
     begin
	assign z = s ? d[2 * T - 1 : T] : d[T - 1 : 0];
     end
   else
     begin
	wire [T-1:0]z1, z2;

	recurse_mux #(.S(S - 1), .T(T)) mux1(.z(z1), .d(d[(2 ** (S - 1)) * T - 1:0]), .s(s[S - 2:0]));

	recurse_mux #(.S(S - 1), .T(T)) mux2(.z(z2), .d(d[(2 ** S) * T - 1:(2 ** (S - 1)) * T]), .s(s[S - 2:0]));

	assign z = s[S - 1] ? z2 : z1;

     end // else: !if(S == 1)
endmodule
