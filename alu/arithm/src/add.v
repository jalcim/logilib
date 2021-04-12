module add (a, b, cin, sub, s, cout);
   input a, b, cin, sub;
   output s, cout;
   /* verilator lint_off UNOPTFLAT */
   wire [2:0] line;

   gate_xor xor1 (a, b, line[0]);
   gate_xor xor2 (cin, line[0], s);
   gate_and and1 (a, b, line[1]);
   gate_and and2 (cin, line[0], line[2]);
   gate_or or3 (line[2], line[1], cout);
endmodule // full_add
