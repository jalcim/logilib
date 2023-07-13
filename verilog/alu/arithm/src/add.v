module add (a, b, cin, sub, s, cout);
   input a, b, cin, sub;
   output s, cout;
   /* verilator lint_off UNOPTFLAT */
   wire [2:0] line;

   xor xor1 (line[0], a, b);
   xor xor2 (s, cin, line[0]);
   and and1 (line[1], a, b);
   and and2 (line[2], cin, line[0]);
   or or1 (cout, line[2], line[1]);
endmodule // full_add
