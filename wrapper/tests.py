#!/usr/bin/env python3

from wrapper import Module, Top
from wrapper import write_top_rtlil

import amaranth as am # THIS SHOULD NOT BE DIRECTLY IMPORTED DIRECTLY

if __name__ == "__main__":

    #######
    # TESTS ENTRYPOINT
    #######

    ##########################################
    # exemple 1 : modules relier dans un top
    ##########################################

    top_1_mod_1 = Module(False, "gate_and", {"WAY": 2, "WIRE": 1})
    top_1_mod_2 = Module(False, "gate_and", {"WAY": 2, "WIRE": 1})
    top_1_mod_3 = Module(True, "gate_and", {"WAY": 2, "WIRE": 1}, i_in=am.Cat(
        top_1_mod_1.get("o_out"),
        top_1_mod_2.get("o_out")
    ))
    top_1 = Top(modules_list = [top_1_mod_1, top_1_mod_2, top_1_mod_3])
    write_top_rtlil(top_1)

    ##########################################
    # exemple 2 : additionner 1bit
    ##########################################

    top_2 = Top() # should be Module() too
    top_2_mod_1 = Module(False, "gate_nand", {"WAY": 2, "WIRE": 1})
    top_2_mod_2 = Module(False, "gate_xor", {"WAY": 2, "WIRE": 1})
    top_2_mod_3 = Module(False, "gate_xor", {"WAY": 2, "WIRE": 1})
    top_2_mod_4 = Module(True, "gate_nand", {"WAY": 2, "WIRE": 1})
    top_2_mod_5 = Module(False, "gate_nand", {"WAY": 2, "WIRE": 1})
    top_2_mod_1.set("i_in", am.Cat(
        top_2.get("i_in"),
        top_2.get("i_in")
    ))
    top_2_mod_2.set("i_in", am.Cat(
        top_2.get("i_in"),
        top_2.get("i_in")
    ))
    top_2_mod_3.set("i_in", am.Cat(
        top_2.get("i_in"),
        top_2.get("i_in"),
        top_2.get("i_in")
    ))
    top_2_mod_4.set("i_in", am.Cat(
        top_2_mod_2.get("o_out"),
        top_2.get("i_in")
    ))
    top_2_mod_5.set("i_in", am.Cat(
        top_2_mod_1.get("o_out"),
        top_2_mod_4.get("o_out")
    ))
    top_2.modules_list = [ # this should work, even after __init__()
        top_2_mod_1,
        top_2_mod_2,
        top_2_mod_3,
        top_2_mod_4,
        top_2_mod_5,
    ]
    write_top_rtlil(top_2)
