module gate_xnor (e1, e2, s);
   input e1, e2;
   output s;

   xnor xnor0(s, e1 ,e2);
endmodule // xor
