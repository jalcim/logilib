module gate_xor (e1, e2, s);
   input e1, e2;
   output s;

   xor xor0(s, e1 ,e2);
endmodule // xor
