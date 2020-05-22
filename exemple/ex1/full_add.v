
/* 
 Ce module est appele "full_add". C'est une description comportementale, niveau
 equations logiques, d'un additionneur 1 bit.
 */

/* Cette ligne definit un "module", autrement dit un bloc, un sous-ensemble.
 
  On donne la liste de ses entrees et sorties (appeles "ports") entre parentheses, 
 en terminant par un point-virgule.

  L'ordre des entrees-sortie importe peu ici, et les habitude changent selon les endroits. 
 Moi j'aime bien cette convention-ci :
   - l'horloge, s'il y en a une, en premier
   - le reset, s'il y en a un, en deuxieme
   - puis les entrees
   - puis les sorties
   - puis les entrees-sorties (bidirectionnelles).
 
 Une bonne habitude est mettre chaque module dans un fichier, et appeler le fichier du même
 nom que le module.
 */
 
module full_add(a, b, cin, s, cout);

   /* Puis on donne la direction des ports
        - "input"  pour une entree
        - "output" pour une sortie
        - "inout"  pour un port bidirectionnel
    Si on ne précise rien, la taille de chaque port est de 1 bit.
    */
     
   input	a;
   input 	b;
   input 	cin;
   output 	s;
   output 	cout;
   
   /* Enfin on donne le type des ports :
       - "wire"
       - "reg"
       - ...
    On verra plus loin ce que ce type signifie. Pour l'instant, acceptons que "wire" signifie "fil".
    */

   wire		a;
   wire 	b;
   wire 	cin;
   wire 	s;
   wire 	cout;

   /* Enfin, on décrit le contenu du bloc.
    On en fait ici une description fonctionnelle, c'est-a-dire qu'on assigne à chaque
    equipotentielle le resultat d'une equation mathematique ou booleenne.
    
    La syntaxe des operateurs est la meme qu'en langage C.
    
    Rappelons les equation du full-adder :
        s    = a XOR B XOR cin;
        cout = (a ET b) OU (cin ET (a XOR b))
    */
   
   assign 	s = a ^ b ^ cin;
   assign       cout = (a & b) | (cin & (a ^b));

   /* On aurait aussi ecrire, plus rapidement : 
	assign {cout, s} = a + b + cin; 
    */
   

endmodule
 
   
   
  
     
   
   

  