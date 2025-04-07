#!/usr/bin/env python3

import sys, os
sys.path.append(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))

import amaranth as am
from Module import Module
from Top import Top
from Cell import Cell

def mod1():
    cell1 = Cell("gate_and", True, False, p_WAY=2, p_WIRE=1)
    cell2 = Cell("gate_and", True, False, p_WAY=2, p_WIRE=1)

    in_3 = am.Cat(cell1.get("o_out"), cell2.get("o_out"))
    cell3 = Cell("gate_and", False, False, p_WAY=2, p_WIRE=1, i_in=in_3)

    in_4 = cell3.get("o_out")
    cell4 = Cell("gate_not", False, True, p_WIRE=1, i_in=in_4)

    mod1 = Module("Mod1", True, False)
    mod1.add_submodules([cell1, cell2, cell3, cell4])
    return mod1

def mod2(in_mod2):
    cell5 = Cell("gate_and", True, False, p_WAY=2, p_WIRE=1)
    cell6 = Cell("gate_and", True, False, p_WAY=2, p_WIRE=1)

    in_7 = am.Cat(cell5.get("o_out"), cell6.get("o_out"))
    cell7 = Cell("gate_and", False, False, p_WAY=2, p_WIRE=1, i_in=in_7)

    in_8 = cell7.get("o_out")
    cell8 = Cell("gate_not", False, True, p_WIRE=1, i_in=in_8)

    mod2 = Module("Mod2", False, True, i_in=in_mod2)
    mod2.add_submodules([cell5, cell6, cell7, cell8])
    return mod2

if __name__ == "__main__":
    mod1 = mod1()
    mod2 = mod2(mod1.get("o_out"))

    top = Top("top")
    top.add_submodules([mod1, mod2])
    # elaboration et ecriture du rtlil
    top.write_rtlil_file()
