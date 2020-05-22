module add (a, b, cin, sub, s, cout);
   input a, b, cin, sub;
   output s, cout;
   wire [3:0] line;

   gate_xor xor0 (b, sub, line[0]);
   gate_xor xor1 (a, line[0], line[1]);
   gate_xor xor2 (cin, line[1], s);
   gate_and and1 (a, line[0], line[2]);
   gate_and and2 (cin, line[1], line[3]);
   gate_or or3 (line[3], line[2], cout);
endmodule // full_add
