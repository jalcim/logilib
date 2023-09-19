`ifndef __MULT_CELL__
 `define __MULT_CELL__

 `include "src/routing/replicator.v"

 `include "src/alu/arithm/divmod2.v"
 `include "src/alu/arithm/addX.v"
 `include "src/primitive/gate/gate_and.v"

module mult_cell(A, B, C, div2, mod2);
   parameter SIZE = 8;

   input A, B, C;

   output [SIZE-1:0] div2;
   output mod2;

   wire line, ignored;
   wire [SIZE-1:0]   sub_repliq;
   wire [SIZE-1:0]   b_line;

//   replicator #(.SIZE(SIZE)) replicator(A_repliq, A);
//   parallel_and #(.SIZE(SIZE)) mux(b_line, B, A_repliq);
   gate_and #(.WAY(SIZE), .WIRE(2)) inst_and(b_line, {B, {SIZE{A}}});
   addX #(.SIZE(SIZE)) inst_add(B, C, 0, line, ignored);
   divmod2 #(.SIZE(SIZE)) inst_divmod2(line, div2, mod2);
endmodule

`endif
