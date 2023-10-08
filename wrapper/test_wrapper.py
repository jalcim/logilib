#!/usr/bin/env python3

import amaranth as am
from wrapper import Module

if __name__ == "__main__":

    # cells : composants primitifs de bas niveau (abstraction matérielle)
    top_mod1 = Module("gate_and", p_WAY=2, p_WIRE=1)  # cells
    top_mod2 = Module("gate_and", p_WAY=2, p_WIRE=1)  # cells
    top_mod3 = Module("gate_and", p_WAY=2, p_WIRE=1)  # cells
    top_mod4 = Module("gate_not", p_WIRE=1)  # cells

    # module : niveau d'abstraction contenant des modules et/ou des cells
    top = Module("top")  # top : le sommet hierarchique du circuit

    # enregistrement des cells/submodules dans le top
    top.add_submodules([top_mod1, top_mod2, top_mod3, top_mod4])

    top_mod1.set("p_WAY", 2)
    top_mod1.set("p_WIRE", 1)
    top_mod2.set("p_WAY", 2)
    top_mod2.set("p_WIRE", 1)
    top_mod3.set("p_WAY", 2)
    top_mod3.set("p_WIRE", 1)
    top_mod4.set("p_WIRE", 1)

    # un module herite des ports de ses enfants
    # si ils sont enregistrés (reg_in/reg_out)
    # 3 level
    # in
    # intern
    # out
    top_mod1.reg_in = True
    top_mod1.reg_out = False
    # level_in
    top_mod2.reg_in = True
    top_mod2.reg_out = False
    # level_in
    top_mod3.reg_in = False
    top_mod3.reg_out = False
    # level_intern
    top_mod4.reg_in = False
    top_mod4.reg_out = True
    # level_out

    # routage
    # l'ordre d'initialisation est importante !
    # "o_out" ne doit JAMAIS se trouver avant "i_in"
    # cet ordre est susceptible de varier sur les cells complexes
    top_mod1.init_sig("i_in")
    top_mod1.init_sig("o_out")
    top_mod2.init_sig("i_in")
    top_mod2.init_sig("o_out")
    top_mod3.set("i_in", am.Cat(top_mod1.get("o_out"), top_mod2.get("o_out")))
    top_mod3.init_sig("o_out")
    top_mod4.set("i_in", top_mod3.get("o_out"))
    top_mod4.init_sig("o_out")

    # finally
    top.write_rtlil_file()
