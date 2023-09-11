#!/usr/bin/env python3

from os import environ

import amaranth as am
from amaranth import Signal, Module, Instance
from amaranth.back import rtlil
from amaranth.hdl import ir
from amaranth.hdl.ir import Fragment
from amaranth.back.rtlil import convert_fragment

from collections import defaultdict, OrderedDict

class Verilog_module(am.Elaboratable):
    def __init__(self, name, id, **kwargs):
        self.kwargs = kwargs
        self.name = name
        self.rtlil_source = "" #affectation dans write_rtlil_file
        self.rtlil_file = self.name + id + ".rtlil"

        self.params = []
        for key in kwargs.keys():
            if key[0:2] in ["p_"]:
                print("PARAM:", key)
                self.params.append(kwargs.get(key))

        self.ports = []
        for key in kwargs.keys():
            if key[0:2] in ["i_", "o_"] or key[0:3] in ["io_"]:
                print("PORT:", key)
                self.ports.append(kwargs.get(key))

    def elaborate(self, platform):
        m = Module()
        m.submodules.verilog = Instance(
            self.name,
            **self.kwargs
        )
        return m


class Regroupement():

    def __init__(self):

        nom_param = "SIZE"
        value_param = 2
        self.modules = [

            Verilog_module(
                "gate_not",
                "0", #attribuer un identifiant unique automatiquement
                **{
                    "i_in" : Signal(1),
                    "o_out" : Signal(1)
                }
            ),
            Verilog_module(
                "gate_and",
                "1",
                **{
                    "p_" + nom_param : 2,#"p_WIDTH": self.width,
                    "i_in" : Signal(2),
                    "o_out" : Signal(1)
                }
            ),
            Verilog_module(
                "gate_and",
                "2",
                **{
                    "p_SIZE": 3,
                    "i_in"  : Signal(3),
                    "o_out" : Signal(1)
                }
            ),
            Verilog_module(
                "gate_and",
                "3",
                **{
                    "p_" + "SIZE": 4,
                    "i_in" : Signal(4),
                    "o_out" : Signal(1)
                }
            )
        ]

def write_rtlil_file(modules_list : Regroupement):
    platform = None
    emit_src = True
    strip_internal_attrs = False

    for module in modules_list.modules:
        fragment = Fragment.get(module, platform).prepare(ports=module.ports)
        rtlil_text, name_map = convert_fragment(
            fragment,
            "wrapper_" + module.name,
            emit_src=emit_src,
        )
        ENV_USERNAME = environ.get("USER")
        module.rtlil_source = rtlil_text.replace(ENV_USERNAME, "user")

        with open(module.rtlil_file, "w") as fd:
            fd.write(module.rtlil_source)
            print(f"'{module.rtlil_file}' filename written.")


if __name__ == "__main__":
    modules_list = Regroupement()
    write_rtlil_file(modules_list)
