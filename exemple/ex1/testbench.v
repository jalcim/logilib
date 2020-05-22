
/* Code de l'environnement de test.
 
 Les environnements de test sont des modules speciaux : ils sont autonomes, ils produisent eux-meme les 
 signaux necessaire au test des autres modules, et verifient eux-memes que ces signaux sont corrects.
 Il n'ont donc pas d'entrees-sorties.
 */

module test;
   
   // Declaration des signaux (equipotentielles, noeuds) internes. Ici tous les signaux sont sur 1 bit
   reg a, b, cin;
   wire s, cout;

   // instanciation de l'additionneur. Nous appelerons cette instance "additionneur_en_test"
   full_add addionneur_en_test(a, b, cin, s, cout);

   /* generation des vecteurs de test
    Tous les vecteurs possibles ne sont pas generes, le test n'est donc pas exhaustif !
    Au debut, a = b = cin = 0.
    Puis vient une pause de 5ns.
    Puis on genere a = 1, b = cin = 0.
    Puis encore une pause de 5ns.
    Puis on essaye a = b = 1 et cin = 0.
    Enfin, apres une pause de 5ns, on teste a = b = cin = 1.
    */
   initial
     begin
	a = 0;
	b = 0;
	cin = 0;
	#5;
	a = 1;
	b = 0;
	cin = 0;
	#5;
	a = 1;
	b = 1;
	cin = 0;
	#5;
	a = 1;
	b = 1;
	cin = 1;
     end // initial begin


   // Ces instructions permettent de garder une trace de toutes les signaux utilisees.
   // Elles seront ecrites dans le fichier "add.vcd", pour visualisation des chronogrammes par GtkWave par exemple
   initial 
     begin
  	$dumpfile ("add.vcd");
  	$dumpvars;
     end

   // Ces instruction permettent de v�rifier en temps reel la valeur des signaux
   // l'instruction "monitor" dit au simulateur d'afficher la valeur des signaux des que l'un d'entre eux change
   initial
     begin
  	$display("\t\ttime,\ta,\tb,\tcin,\ts,\tcout");
  	$monitor("%d \t%b \t%b \t%b \t%b \t%b",$time, a, b, cin, s, cout);
     end
   
   // fin du module de test
endmodule // test
