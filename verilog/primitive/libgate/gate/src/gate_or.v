module gate_or (e1, e2, s);
   input e1, e2;
   output s;

   or or0(s, e1, e2);
endmodule // or
