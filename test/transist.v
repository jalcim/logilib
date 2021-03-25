/*
module test_transistor;
   wire a,b,c,d,e,f,g,h;
   wire i,j,k,l;

   supply1 vcd;
   supply0 gnd;

   pmos     pmos_0    (a, b, c);
   rpmos    rpmos_0   (a, b, c);
   nmos     nmos_0    (a, b, c);
   rnmos    rnmos_0   (a, b, c);
   cmos     cmos_0    (a, b, c);
   rcmos    rcmos_0   (a, b, c);
   tranif1  tranif1_0 (a, b, c);
   tranif0  tranif0_0 (a, b, c);   
   rtranif1 rtranif1_0(a, b, c);
   rtranif0 rtranif0_0(a, b, c);   
   tran     tran_0    (a, b, c);
   rtran    rtran_0   (a, b, c);
   pullup   pullup_0  (a, b, c);
   pulldown pulldown_0(a, b, c);
   
endmodule
*/

module gate_not (out, in);
   output out;
   input in;
   supply0 GND;
   supply1 PWR;
   
   pmos(out, PWR, in);
   nmos(out, GND, in);
endmodule

module test_npmos;
   reg ctrl;
   wire [1:0] out;

//   npmos npmos0(in, ctrl, out);
//   cmos (out[0], d, ctrl, ctrl);
   cmos_inverter cmos_inverter(out[0], ctrl);
   
   initial
     begin
	ctrl = 0;

	$monitor("d=%b, ctrl=%b, out[0]=%b, out[1]=%b\n", d, ctrl, out[0], out[1]);

	ctrl = 0;
	#5;
	ctrl = 0;
	#5;
	ctrl = 1;
	#5;
	ctrl = 1;
	#5;

     end
endmodule	
