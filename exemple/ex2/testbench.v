
/* Code de l'environnement de test.
 
 Ce module effectue un test exhaustif des trois versions de l'additionneur 1 bit :
	- structurel
	- comportemental haut niveau
	- comportemental niveau equations logiques
 */

module test;
   
   // Declaration des signaux (equipotentielles, noeuds) internes. Ici tous les signaux sont sur 1 bit
   reg a, b, cin;

   // Declaration des noeuds internes.
   
   // D'abord les sorties des modules : ils sont affectes en permanence, sont donc des wire
   wire s1, s2, s3;
   wire c1, c2, c3;

   // Autres noeuds internes
   //   error_found : pour savoir si on a trouve une erreur ou non. C'est une variable, donc reg
   //   clk         : on synchronise les tests sur une horloge. C'est pratique au cas ou les additionneurs
   //                 ont un temps de propagation : on prend alors une horloge suffisament lente pour leur
   //                 laisser le temps de se stabiliser. On ne teste leur sortie qu'au front d'horloge suivant.
   reg 	error_found;
   reg 	clk;
   
   
   // Instanciation des additionneurs. 
   full_add_struc     add1(a, b, cin, s1, c1);
   full_add_comp_high add2(a, b, cin, s2, c2);
   full_add_comp_low  add3(a, b, cin, s3, c3);


   // On garde une trace des signaux pour les chronogrammes, c'est toujours joli a voir :) ...
   initial 
     begin
  	$dumpfile ("add.vcd");
  	$dumpvars;
     end


   // Generation des vecteurs de test
   //   On commence par initialiser tous les signaux a zero, et afficher un message de bienvenue
   initial
     begin
	clk = 0;
	a = 0;
	b = 0;
	cin = 0;
	error_found = 0;
	
	$display("Debut de la simulation");
	$display("\t\ta\tb\tc");
     end

   
   // on genere une horloge de 10ns de periode
   always
     #5 clk <= !clk;

   
   // A chaque front montant de l'horloge, on commence par verifier que les sorties de additionneurs
   // sont correctes.
   // Puis on change de combinaison de test
   // Si on a teste toutes les combinaisons, on s'arrete
   always @(posedge clk)
     begin
	// Test des sorties
	$display("Testing : \t%b\t%b\t%b", a, b, cin);
	if ((2*c1+ s1) != (a+b+cin))
	  begin
	     $display("ERREUR : additionneur full_add_struc :");
	     $display("\ta=%b, b=%b, cin=%b et s=%b, cout=%b", a, b, cin, s1, c1);
	     error_found <= 1;
	  end
	if ((2*c2+ s2) != (a+b+cin))
	  begin
	     $display("ERREUR : additionneur full_comp_high :");
	     $display("\ta=%b, b=%b, cin=%b et s=%b, cout=%b", a, b, cin, s2, c2);
	     error_found <= 1;
	  end
	if ((2*c3+ s3) != (a+b+cin))
	  begin
	     $display("ERREUR : additionneur full_comp_low :");
	     $display("\ta=%b, b=%b, cin=%b et s=%b, cout=%b", a, b, cin, s3, c3);
	     error_found <= 1;
	  end

	// Changement de combinaison
	{a,b,cin} <= {a,b,cin} + 1;

	// A-t-on tout teste ?
	// Attention, l'affectation ci-dessus ne sera prise en compte qu'au prochain delta-cycle !!!
	if({a,b,cin}==7)
	  begin
	     if(!error_found)
	       $display("SIMULATION CORRECTE !!!\n\n");
	     else
	       $display("SIMULATION INCORRECTE !!!\n\n");
	     $finish;
	  end
     end

   
   // fin du module de test
endmodule // test
