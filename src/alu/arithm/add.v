`ifndef __ADD__
 `define __ADD__

module add (a, b, cin, out, cout);
   input a, b, cin;
   output out, cout;
   /* verilator lint_off UNOPTFLAT */
   wire [2:0] line;

   nand nand1 (line[0], a, cin);
   xor xor1 (line[1], a, cin);
   nand nand2 (line[2], line[1], b);
   nand nand3 (cout, line[0], line[2]);
   assign out = (a ^ b ^ cin);
endmodule // full_add

`endif
