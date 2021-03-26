La logilib est une bibliotheque de circuit logique structurel.

L'objectif n'est pas le design sur FPGA, cette librairie vise le design sur ASIC.

En d'autres mots ICI PAS DE RTL !!!
Tout est schematiser a partir des primitives de portes logique fournit par le verilog,
Et nous avons meme pousser le vice a refaire les portes logiques avec les primitives CMOS fournit par le verilog.

Le but etant de creer tous les circuits necessaire a un processeur de maniere totalement explicite,
Ceci en gardant une vision purement electronique et schematique.

Cependant comme certain composants sont souvent recurant avec de petite variantes, ou meme sont present des centaines/millier de fois,
nous ne nous privons donc pas de la puissances des parameters de verilog, ni de son approche recursive permettant la generation des circuits.

La premiere version de cette librairie etais entierement schematique, et etais tester sur simulateur logique,
Cependant cette approche a limiter la taille des circuits a 8bit (je ne me voyais pas cabler 52536 bascule...).

La 2 eme version (celle en verilog) apporte donc ce dynamisme qui a terme permettra d'avoir nos circuits en 8/16/32/64/128 bit,
Ceci en modifiant simplement les parameters, voir a terme en modifiant simpement un fichier de configuration.
Cette version est integralement developper pour le simulateur iverilog et la synthese via yosys fais ses premiers pas.

Chaque module est accompagner de 2 schema,
un schema logique 8 bit sur lequel son idee repose,
et un schema "finite state machine" qui est sa representation reel (generer par yosys).



