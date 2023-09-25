#!/usr/bin/env python3

from os import environ

import amaranth as am
# from amaranth import Signal, Module, Instance
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
        m = am.Module()
        m.submodules.verilog = am.Instance(
            self.name,
            **self.kwargs
        )
        return m

# must be updated with each module_type
ALLOWED_PARAMS = {
    "gate_and": ["WAY", "WIRE"],
    "gate_or": ["WAY", "WIRE"],
    "gate_not": ["WIRE"],
    "gate_nand": ["WAY", "WIRE", "BEHAVIORAL"],
}

class Module():

    module_id = 0 # auto increment

    def __init__(self, module_type, params):
        if module_type == "gate_or":
            self.params = {
                "i_in" : am.Signal(params["WAY"] * params["WIRE"]),
                "o_out": am.Signal(params["WIRE"]),
            }
        elif module_type == "gate_and":
            self.params = {
                "i_in" : am.Signal(params["WAY"] * params["WIRE"]),
                "o_out": am.Signal(params["WIRE"]),
            }
        elif module_type == "gate_nand":
            self.params = {
                "i_in" : am.Signal(params["WAY"] * params["WIRE"]),
                "o_out": am.Signal(params["WIRE"]),
            }
        elif module_type == "gate_not":
            self.params = {
                "i_in" : am.Signal(params["WIRE"]),
                "o_out": am.Signal(params["WIRE"]),
            }
        self.params.update({"p_" + key: value for key, value in params.items() if key in ALLOWED_PARAMS[module_type]})
        self.module = Verilog_module(
            module_type,
            str(Module.module_id),
            **self.params
        )
        Module.module_id += 1


def write_rtlil_file(modules_list : list):
    platform = None
    emit_src = True
    strip_internal_attrs = False

    for elem in modules_list:
        fragment = Fragment.get(elem.module, platform).prepare(ports=elem.module.ports)
        rtlil_text, name_map = convert_fragment(
            fragment,
            "wrapper_" + elem.module.name,
            emit_src=emit_src,
        )
        ENV_USERNAME = environ.get("USER")
        elem.module.rtlil_source = rtlil_text.replace(ENV_USERNAME, "user")

        with open(elem.module.rtlil_file, "w") as fd:
            fd.write(elem.module.rtlil_source)
            print(f"'{elem.module.rtlil_file}' filename written.")


if __name__ == "__main__":
    # exemple :
    modules_list = [
        Module("gate_not", {"WIRE": 1}),
        Module("gate_or", {"WAY": 2, "WIRE": 1}),
        Module("gate_and", {"WAY": 2, "WIRE": 1}),
        Module("gate_nand", {"WAY": 2, "WIRE": 1, "BEHAVIORAL": 1})
    ]
    write_rtlil_file(modules_list)
