`ifndef __CMP__
 `define __CMP__

 `include "src/primitive/parallel_gate/parallel_nor.v"
 `include "src/primitive/complex_gate/complex_gate.v"
 `include "src/primitive/parallel_gate/parallel_and.v"

module cmp_cell(e1, e2, left, right);
   input e1, e2;
   output left, right;
   wire [1:0]  line;

   not not1(line[0], e1);
   and and1(right, e2, line[0]);

   not not2(line[1], e2);
   and and2(left, e1, line[1]);
endmodule

module parallel_cmp_cell(a, b, left, right);
   parameter WIRE = 8;

   input [WIRE-1:0] a, b;

   output [WIRE-1:0] left, right;

   cmp_cell cmp_cell_inst(a[0], b[0], left[0], right[0]);
   if (WIRE > 1)
     parallel_cmp_cell #(.WIRE(WIRE-1)) parallel_cmp_cell_recall(a[WIRE-1:1], b[WIRE-1:1], left[WIRE-1:1], right[WIRE-1:1]);
endmodule

module recursive_ao(out, e1, e2, e3);
   parameter WIRE = 8;

   input	  e1;
   input [WIRE-2:0] e2, e3;
   output	    out;
   wire		    line;

   gate_ao ao_inst1(line, {e1, e2[0], e3[0]});
   if (WIRE > 2)
     recursive_ao #(.WIRE(WIRE-1)) recall(out, line, e2[WIRE-2:1], e3[WIRE-2:1]);
   else
     assign out = line;
endmodule

module cmp(a, b, eq, more, less);
   parameter WIRE = 8;
   input [WIRE-1:0] a, b;

   output	    eq, less,more;

   wire [WIRE-1:0]  left, right, out_nor;

   wire		    out_and;
   wire		    out_ao;

   parallel_cmp_cell #(.WIRE(WIRE)) parallel_cmp_cell_inst(a, b, left, right);
   parallel_nor #(.WAY(2), .WIRE(WIRE)) parallel_nor_inst(out_nor, {left, right});

   recursive_ao #(.WIRE(WIRE)) ao_inst(out_ao,
				       left[0],
				       out_nor[WIRE-1:1],
				       left[WIRE-1:1]);

   serial_and #(.WAY(WIRE)) and_inst(out_and, out_nor);

   nor nor_inst(more, out_ao, out_and);
   buf buf_inst_less(eq, out_and);
   buf buf_inst_more(less, out_ao);
endmodule

`endif
