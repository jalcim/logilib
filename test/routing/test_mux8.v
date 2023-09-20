`include "src/routing/mux.v"

module test_mux8;
   parameter S = 2;
   parameter T = 8;

   localparam NB_IN = 2 ** S;
   localparam SIZE_IN = NB_IN * T;

   wire [T - 1 : 0] out;
   reg [SIZE_IN - 1 : 0] in;
   reg [S-1 : 0] ctrl;

   integer     cpt1;
   integer     cpt2;
   reg 	       xin;

   mux #(.S(S), .T(T)) mux0(ctrl, in, out);

   initial
     begin
	$dumpfile("signal_mux8.vcd");
	$dumpvars;

 	xin = 0;

	cpt1 = -1;
	cpt2 = 0;
	while (++cpt1 < NB_IN)
	  begin
	     while (cpt2 < (cpt1+1)*T)
	       begin
		  in[cpt2] = xin;
		  xin = ~xin;
		  cpt2++;
	       end
	     xin = ~xin;
	     $display("\t\tin[%d] = %b", cpt1, in[cpt1 * T +: 8]);//:cpt1 * T]);
	  end

	$display("\t\ttime, \tout, \t\tctrl");
	$monitor("%d\t%b\t%b", $time, out[7:0], ctrl[1:0]);

	ctrl[0] = 0;
	ctrl[1] = 0;
	#5;
	ctrl[0] = 1;
	ctrl[1] = 0;
	#5;
	ctrl[0] = 0;
	ctrl[1] = 1;
	#5;
	ctrl[0] = 1;
	ctrl[1] = 1;
	#5;
     end
endmodule
