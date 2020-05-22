
/* 
 Ceci est une description strcturelle d'un additionneur 1 bit.
 */
 
module full_add_struc(a, b, cin, s, cout);

   input	a, b, cin;
   output 	s, cout;
   
   wire		a, b, cin, s, cout;

   /* 
    Declaration de noeuds internes. Dans une description structurelles, les noeuds sont des wires (ce 
    ne sont pas des variables qu'on affecte de temps en temps et qui doivent memoriser des valeurs. ce 
    des noeuds qui sont affectes en continu soit par les entrees du module, soit par les sorties des
    portes internes)
    */

   wire 	d, e, f;
   
   
   /* 
    Description structurelle : on instancie des portes logiques predefinies en Verilog, et on s'occupe surtout
    de la façon dont on doit les relier...
    Les portes logiques predefinies sont : and, nand, or, nor, xor, xnor, not, ...
    
    Attention: dans les portes Verilog standard, le premier argument est la SORTIE, les suivants sont les entrees !
    */

   xor xor1(d, a, b);
   and and1(e, a, b);
   and and2(f, d, cin);
   xor xor2(s, d, cin);
   or  or1(cout, e, f);
         
endmodule
 