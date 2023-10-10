#!/usr/bin/env python3

import amaranth as am
from wrapper import Module

if __name__ == "__main__":

    # cells : composants primitifs de bas niveau (abstraction matérielle)
    # si ils sont enregistrés, le module pere herite de leurs ports
    top_cell1 = Module("gate_and", True, False, p_WAY=2, p_WIRE=1)
    top_cell2 = Module("gate_and", True, False, p_WAY=2, p_WIRE=1)

    # routage
    in_3 = am.Cat(top_cell1.get("o_out"), top_cell2.get("o_out"))
    top_cell3 = Module("gate_and", False, False, p_WAY=2, p_WIRE=1, i_in=in_3)

    in_4 = top_cell3.get("o_out")
    top_cell4 = Module("gate_not", False, True, p_WIRE=1, i_in=in_4)

    top = Module("top")
    # enregistrement des cells/submodules dans le Module pere 
    top.add_submodules([top_cell1, top_cell2, top_cell3, top_cell4])

    # elaboration et ecriture du rtlil
    top.write_rtlil_file()
