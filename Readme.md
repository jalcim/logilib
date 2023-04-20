La logilib est une bibliotheque verilog structurelle recursive.
yosys est utiliser afin de generer la netlist finale.

Elle vise a fournir tous les circuits existant, ceci en fournissant une abstraction materiel hautement configurable au travers de module abstrait de haut niveau : exemple 50 nand a 5 entrer en parrallele ou en serie.

Elle implemente tous les type de simulation (icarus, verilator, spice).

Elle est constituer de sous partie : 
- libgate (un simple wrapper de porte logique pour permettre de rester abstrait vis a vis du materiel)
- libcmos (une implementation des primites logiques et sequeniels : exemple sram nand Dlatch)
- libanalog (TODO) une librairie en langage SPICE avec des wrapper verilog en blackbox.

La taille de tous les circuits est arbitrairement configurable (32, 64, 42 bit).

Chaque module est accompagner de 2 schema,
un schema logique 8 bit sur lequel son idee repose (taille et techno configurable).
et un schema "finite state machine" qui est sa representation reel (generable par yosys).



