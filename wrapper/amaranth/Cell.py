#!/usr/bin/env python3

import datetime
from os import environ
from os import _exit

import amaranth as am
from amaranth.back.rtlil import convert_fragment
from amaranth.hdl.ir import Fragment

PRIMITIVE = {
    "gate_and",
    "gate_or",
    "gate_nor",
    "gate_xor",
    "gate_xnor",
    "gate_not",
    "gate_buf",
    "gate_nand",
}

class Cell():
    unique_id = 0  # auto increment
    kwargs: dict = {}
    name = "default"
    submodules_list: list = []

    reg_in = False
    reg_out = False
    verilog = None

    def __init__(self, module_type: str = "default", reg_in: bool = False, reg_out: bool = False, **kwargs):
        self.kwargs = kwargs
        self.name = module_type + "_" + str(Cell.unique_id)
        self.module_type = module_type
        self.ports: list = []
        self.reg_in = reg_in;
        self.reg_out = reg_out;
        self.init_sig()
        # nothing below increment
        Cell.unique_id += 1

    def init_sig(self):
        self.init_primitive_sig()

    def init_primitive_sig(self):
        if self.module_type in PRIMITIVE:
            if "p_WIRE" not in self.kwargs or self.kwargs["p_WIRE"] == None:
                print("'\033[91m'Error : module " + self.module_type + " require p_WIRE definition'\033[95m'")
                _exit(-1)
            if "i_in" not in self.kwargs:
                if self.module_type in [
                        "gate_buf",
                        "gate_not",
                ]:
                    self.set("i_in", am.Signal(self.kwargs["p_WIRE"]))
                else :
                    if "p_WAY" not in self.kwargs or self.kwargs["p_WAY"] == None:
                        print("'\033[91m'Error : module " + self.module_type + " require p_WAY definition'\033[95m'")
                        _exit(-1)
                    self.set("i_in", am.Signal(self.kwargs["p_WAY"] * self.kwargs["p_WIRE"]))
            else :
                self.set("i_in", self.kwargs["i_in"])
            self.set("o_out", am.Signal(self.kwargs["p_WIRE"]))
            self.init_cells()

    def init_cells(self):
        self.verilog = am.Instance(self.module_type, **self.kwargs)

    def get(self, key: str):
        return self.kwargs.get(key)

    def set(self, key: str, value):
        self.kwargs[key] = value
