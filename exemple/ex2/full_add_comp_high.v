
/* 
 Ceci est une description comportementale de plus haut niveau d'un additionneur 1 bit.
 */
   /* 
Description comportementale de haut niveau : la fonctionalite recherche est celle d'un additionneur
1 bit, c'est a dire : a + b + cin = s, avec eventuellement une retenue cout.
Ce qui se traduit sous forme vectorielle par : {cout, s} = a + b + cin.
On aurait pu ecrire "assign {cout, s} = a + b + cin;" si cout et s avaient ete declares en wire.
Mais comme on veut voir les regs, la syntaxe change !
*/
 
module full_add_comp_high(a, b, cin, s, cout);

   input	a, b, cin;
   output 	s, cout;
   
   wire		a, b, cin;

   // s et cout sont ici definis en reg. Ce sont des variables, c'est a dire qu'ils peuvent etre affectes dans un processus, et garder
   // leur valeur entre deux appels du processus
   reg 		s, cout;

   /* On declare ici un processus, qui modelise une fonction combinatoire. Ce processus affecte cout et s, et doit
    etre evalue a chaque changement de la valeur des entrees (a, b, cin)
    */

   always @(a or b or cin)
     {cout, s} = a + b + cin;
      
endmodule
 
