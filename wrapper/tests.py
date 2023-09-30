#!/usr/bin/env python3

from wrapper import Module
# from wrapper import write_rtlil_file

import amaranth as am # THIS SHOULD NOT BE DIRECTLY IMPORTED DIRECTLY

if __name__ == "__main__":

    #######
    # TESTS ENTRYPOINT
    #######

    # must be in this order :
    # 1. declare everything
    # 2. plug things between themselves
    # 3. generate rtlil

    ##########################################
    # exemple 1 : modules relier dans un top
    ##########################################

    top_1_mod_1 = Module("gate_and", p_WAY=2, p_WIRE=1)
    top_1_mod_1.init_sig("o_out")
    top_1_mod_2 = Module("gate_and", p_WAY=2, p_WIRE=1)
    top_1_mod_2.init_sig("o_out")
    top_1_mod_3 = Module("gate_and", p_WAY=2, p_WIRE=1, i_in=am.Cat(
        top_1_mod_1.get("o_out"),
        top_1_mod_2.get("o_out")
    ))
    top_1 = Module("top_1", p_WAY=8, p_WIRE=8)
    top_1.add_submodules([
        top_1_mod_1,
        top_1_mod_2,
        top_1_mod_3
    ])
    top_1.write_rtlil_file()

    ##########################################
    # exemple 2 : additionner 1bit
    ##########################################

    top_2 = Module("top_2", p_WAY=8, p_WIRE=8)
    top_2.init_sig("i_in")
    top_2_mod_1 = Module("gate_nand", p_WAY=2, p_WIRE=1)
    top_2_mod_1.init_sig("o_out")
    top_2_mod_2 = Module("gate_xor", p_WAY=2, p_WIRE=1)
    top_2_mod_2.init_sig("o_out")
    top_2_mod_3 = Module("gate_xor", p_WAY=2, p_WIRE=1)
    top_2_mod_4 = Module("gate_nand", p_WAY=2, p_WIRE=1)
    top_2_mod_4.init_sig("o_out")
    top_2_mod_5 = Module("gate_nand", p_WAY=2, p_WIRE=1)

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
    top_2.write_rtlil_file()
