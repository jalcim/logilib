module cpt_bin(activate, clk, reset, out);
   parameter SIZE = 8;
   input activate, clk, reset;
   output [SIZE-1:0] out;

   wire [SIZE-1:0]   line;
   wire 	     ignore;

   and #(.SIZE(SIZE)) and_activate(activate, clk, line[0]);
endmodule // cpt_bin

module cpt_bin_recall(clk, out, reset);
   parameter SIZE = 8;
   supply1 power;

   input   clk, reset;
   output [SIZE-1:0] out;

   if (SIZE == 1)
     begin
	JKlatchUP JK0(power, power, clk, reset, out[0], line[1]);
     end
   else
     begin
	
     end
     
endmodule
   
