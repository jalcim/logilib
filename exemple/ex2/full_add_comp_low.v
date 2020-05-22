
/* 
 Ceci est une description comportementale de bas niveau d'un additionneur 1bit.
 C'est le même code Verilog que celui étudié dans l'exemple 1.
 */
 
module full_add_comp_low(a, b, cin, s, cout);

   input	a, b, cin;
   output 	s, cout;
   
   wire		a, b, cin, s, cout;

   assign 	s = a ^ b ^ cin;
   assign       cout = (a & b) | (cin & (a ^ b));

endmodule
 
