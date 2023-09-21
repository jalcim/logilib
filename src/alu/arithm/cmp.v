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

module cmp(a, b, eq, more, less);
   parameter WIRE = 8;
   input [WIRE-1:0] a, b;

   output	    eq, less,more;

   wire [WIRE-1:0]  left, right, out_nor;
   wire [WIRE-2:0]  out_ao;//, out_buf_and;
   wire		    out_and;

   parallel_cmp_cell #(.WIRE(WIRE)) parallel_cmp_cell_inst(a, b, left, right);
   parallel_nor #(.WAY(2), .WIRE(WIRE)) parallel_nor_inst(out_nor, {left, right});

   //ao x7
   gate_ao ao_inst1(out_ao[0], {left[0]  , out_nor[1], left[1]});
   gate_ao ao_inst2(out_ao[1], {out_ao[0], out_nor[2], left[2]});
   gate_ao ao_inst3(out_ao[2], {out_ao[1], out_nor[3], left[3]});
   gate_ao ao_inst4(out_ao[3], {out_ao[2], out_nor[4], left[4]});
   gate_ao ao_inst5(out_ao[4], {out_ao[3], out_nor[5], left[5]});
   gate_ao ao_inst6(out_ao[5], {out_ao[4], out_nor[6], left[6]});
   gate_ao ao_inst7(out_ao[6], {out_ao[5], out_nor[7], left[7]});

//   parallel_buf #(.WIRE(WIRE)) buf_and_inst(out_buf_and, out_nor);
   serial_and #(.WAY(WIRE)) and_inst(out_and, out_nor);//out_buf_and);

   nor nor_inst(more, out_ao[6], out_and);
   buf buf_inst_less(eq, out_and);
   buf buf_inst_more(less, out_ao[6]);
endmodule

`endif
