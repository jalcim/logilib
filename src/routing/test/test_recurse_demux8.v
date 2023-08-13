module test_recurse_demux8;
   parameter S = 2;
   parameter T = 8;

   wire [(2 ** S) * T- 1 : 0] out; 
   reg [T - 1 : 0] in;
   reg [1 : 0] ctrl;

   integer     cpt;
   reg 	       xin;

   recurse_demux #(.S(S), .T(T))demux0(ctrl, in, out);

   initial
     begin
	$dumpfile("build/routing/signal/signal_recurse_demux8.vcd");
	$dumpvars;
	$display("\t\ttime, \tout[0],\tout[1],\tout[2],\tout[3],\tin,\tctrl");
	$monitor("%d \t%d \t%d \t%d \t%d \t%d \t%d", $time, out[7:0], out[15:8], out[23:16], out[31:24], in, ctrl);

        cpt = -1;
	xin = 0;
	while (++cpt <= (2**S) * T - 1)
	  begin
	     in[cpt] = xin;
	     xin = ~xin;
	  end
	
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
