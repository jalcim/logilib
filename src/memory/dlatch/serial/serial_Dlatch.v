`ifndef __SERIAL_DLATCH__
 `define __SERIAL_DLATCH__

module serial_Dlatch(D, clk, Q, QN);
   parameter WIRE = 1;

   input	  clk;
   input [WIRE -1:0] D;
   output [WIRE -1:0] Q, QN;

   /* verilator lint_off UNOPTFLAT */
   wire [4:0] line;

   /* verilator lint_off UNOPTFLAT */
   wire	      line2;

   not not0(line[0], clk);
   nor nor0(line[1], D[0], line[0]);
   nor nor1(line2, line[1], line[4]);
   and and2(line[3], D[0], clk);
   nor nor3(line[4], line[3], line2);

   assign Q[0]  = line2;
   assign QN[0] = line[4];

   if (WIRE > 1)
     serial_Dlatch #(.WIRE(WIRE-1)) recall(.D(D[WIRE-1:1]),
					   .clk(clk),
					   .Q(Q[WIRE-1:1]),
					   .QN(QN[WIRE-1:1]));
endmodule

`endif
