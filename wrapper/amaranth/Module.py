#!/usr/bin/env python3

import datetime
from os import environ
from os import _exit

import amaranth as am
from amaranth.back.rtlil import convert_fragment
from amaranth.hdl.ir import Fragment

class Module(am.Elaboratable):
    unique_id = 0  # auto increment
    kwargs: dict = {}
    name = "default"
    submodules_list: list = []
    verilog = None

    reg_in = False
    reg_out = False
    ports: list = []

    def __init__(self, module_type: str = "default", reg_in: bool = False, reg_out: bool = False, **kwargs):
        self.module = am.Module()
        self.kwargs = kwargs
        self.name = module_type + "_" + str(Module.unique_id)
        self.ports: list = []
        self.reg_in = reg_in;
        self.reg_out = reg_out;
        # nothing below increment
        Module.unique_id += 1

    def get(self, key: str):
        return self.kwargs.get(key)

    def set(self, key: str, value):
        self.kwargs[key] = value

    def add_submodules(self, new_modules: list):
        for sub_mod in new_modules:
            self.submodules_list.append(sub_mod)
            if sub_mod.verilog != None:
                self.module.submodules += sub_mod.verilog
            else :
                self.module.submodules += sub_mod
            # enregistrement des ports des submodules dans les ports du père
            for key in sub_mod.kwargs.keys():
                if key[0:2] in ["i_", "o_"] or key[0:3] in ["io_"]:
                    if sub_mod.reg_in is False and sub_mod.reg_out is False:
                        print("Module no port to reg")
                    elif sub_mod.reg_in is False:
                        if key[0:2] in ["o_"]:
                            print("Module port reg", key)
                            self.ports.append(sub_mod.kwargs.get(key))
                    elif sub_mod.reg_out is False:
                        if key[0:2] in ["i_"]:
                            print("Module port reg", key)
                            self.ports.append(sub_mod.kwargs.get(key))
                    else:  # io_ tombe ici (actuellement non geré)
                        print("Module port reg", key)
                        self.ports.append(sub_mod.kwargs.get(key))
    def elaborate(self, platform):
        # SEUL LE TOP APPELLE CETTE FONCTION
        return self.module
