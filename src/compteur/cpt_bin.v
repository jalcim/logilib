`ifndef __CPT_BIN__
 `define __CPT_BIN__

 `include "src/memory/JKlatch/JKlatch_rst.v"

module cpt_bin(activate, clk, reset, out);
   parameter SIZE = 8;
   input activate, clk, reset;
   output [SIZE-1:0] out;

   wire [SIZE-1:0]   line;
   supply1	     vcc;
   supply0	     ignore;

   if (SIZE >= 1)
     begin
	and and_activate(line[0], activate, clk);
	JKlatchUP_rst JK0(vcc, vcc, line[0], reset, out[0], line[1]);
	if (SIZE > 1)
	  begin
	     cpt_bin_recall #(.SIZE(SIZE-1)) inst(line[1], out[SIZE-1:1], reset);
	  end
     end

endmodule // cpt_bin

module cpt_bin_recall(clk, out, reset);
   parameter SIZE = 8;
   supply1 vcc;

   input   clk, reset;
   output [SIZE-1:0] out;   

   wire	     line;

   if (SIZE == 1)
     begin
	JKlatchUP_rst JK_UP(vcc, vcc, clk, reset, out[0], line);
     end
   else if (SIZE > 1)
     begin
	JKlatchUP_rst JK_UP(vcc, vcc, clk, reset, out[0], line);
	cpt_bin_recall #(.SIZE(SIZE-1)) recurse(line, out[SIZE-1:1], reset);
     end

endmodule // cpt_bin_recall

`endif
