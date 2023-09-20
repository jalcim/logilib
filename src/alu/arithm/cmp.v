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

module cmp(a, b, eq, less, more);
   parameter WIRE = 8;
   input [WIRE-1:0] a, b;
   wire [WIRE-1:0]  left, right;
   wire [WIRE-1:0]  out_nor;

   parallel_cmp_cell #(.WIRE(WIRE)) parallel_cmp_cell_inst(a, b, left, right);

   parallel_gate_nor #(.WAY(2), .WIRE(WIRE)) parallel_gate_nor_inst(out_nor, left, right);
   
endmodule
