module not (e1, s);
   input e1;
   output s;

   assign s = ~e1;
endmodule; // not

module and (e1, e2, s);
   input e1;
   input e2;
   output s;

   assign s = e1 & e2;
endmodule; // and

module or (e1, e2, s);
   input e1, e2;
   output s;

   assign s = e1 | e2;
endmodule; // or

module xor (e1, e2, s);
   input e1, e2;
   output s;
 
   assign s = e1 ^ e2;
endmodule; // xor

module nand (e1, e2, s);
   input e1, e2;
   output s;

   assign s = e1 ~& e2;
endmodule; // nand
  
module nor (e1, e2, s);
   input e1, e2;
   output s;

   assign s = e1 ~| e2;
endmodule; // nor
