#!/usr/bin/env python3

from os import environ
import datetime

import amaranth as am
from wrapper import Module
from amaranth.back.rtlil import convert_fragment
from amaranth.hdl.ir import Fragment

class Top(am.Elaboratable):
    submodules_list: list = []
    ports: list = []
    
    def __init__(self, module_name: str = "Top"):
        self.top = am.Module()
        self.name = module_name
        
    def elaborate(self, platform):
        # SEUL LE TOP APPELLE CETTE FONCTION
        self.reg_port()
        return self.top

    def reg_port(self):
        for sub_mod in self.submodules_list:
            setattr(
                self.top.submodules,
                f"{sub_mod.name}.verilog",
                sub_mod.verilog,
            )
            # enregistrement des ports des submodules dans les ports du père
            for key in sub_mod.kwargs.keys():
                if key[0:2] in ["i_", "o_"] or key[0:3] in ["io_"]:
                    if sub_mod.reg_in is False and sub_mod.reg_out is False:
                        print("no port to reg")
                    elif sub_mod.reg_in is False:
                        if key[0:2] in ["o_"]:
                            print("port reg", key)
                            self.ports.append(sub_mod.kwargs.get(key))
                    elif sub_mod.reg_out is False:
                        if key[0:2] in ["i_"]:
                            print("port reg", key)
                            self.ports.append(sub_mod.kwargs.get(key))
                    else:  # io_ tombe ici (actuellement non geré)
                        print("port reg", key)
                        self.ports.append(sub_mod.kwargs.get(key))

    def add_submodules(self, new_modules: list):
        for sub_mod in new_modules:
            self.submodules_list.append(sub_mod)

    def write_rtlil_file(self):
        platform = None
        emit_src = True
        fragment = Fragment.get(self, platform).prepare(ports=self.ports)
        rtlil_text, name_map = convert_fragment(
            fragment,
            self.name,
            emit_src=emit_src,
        )
        ENV_USERNAME = environ.get("USER")
        rtlil_source_text = rtlil_text.replace(ENV_USERNAME, "user")
        now = datetime.datetime.now().strftime("%Y-%m-%d_%H-%M-%S")
        filename = self.name + "_" + now + ".rtlil"
        with open(filename, "w") as fd:
            fd.write(rtlil_source_text)
            print(f"{filename} file written.")

