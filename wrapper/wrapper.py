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

ALLOWED_PARAMS = {
    # must be updated with each module_type
    "gate_and": ["p_WAY", "p_WIRE"],
    "gate_or": ["p_WAY", "p_WIRE"],
    "gate_nor": ["p_WAY", "p_WIRE"],
    "gate_xor": ["p_WAY", "p_WIRE"],
    "gate_xnor": ["p_WAY", "p_WIRE"],
    "gate_not": ["p_WIRE"],
    "gate_buf": ["p_WIRE"],
    "gate_nand": ["p_WAY", "p_WIRE"],
    # new cells types must be added above this
    # les cells complexe auront d'autres parametres
    "default": ["p_WAY", "p_WIRE"],  # define defaut required parameters
}

class Module(am.Elaboratable):  # this is a recursive Element
    unique_id = 0  # auto increment
    kwargs: dict = {}
    name = "default"
    submodules_list: list = []

    reg_in = False
    reg_out = False

    def __init__(self, module_type: str = "default", reg_in: bool = False, reg_out: bool = False, **kwargs):
        self.kwargs = kwargs
        self.name = module_type + "_" + str(Module.unique_id)
        self.module_type = module_type
        self.ports: list = []
        self.reg_in = reg_in;
        self.reg_out = reg_out;
        self.init_sig()
        # nothing below increment
        Module.unique_id += 1

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


    def get(self, key: str):
        return self.kwargs.get(key)

    def set(self, key: str, value):
        self.kwargs[key] = value

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

    def elaborate(self, platform):
        # SEUL LE TOP APPELLE CETTE FONCTION
        top = am.Module()
        self.reg_port(top)
        return top

    def reg_port(self, top):
        for sub_mod in self.submodules_list:
            verilog = am.Instance(sub_mod.module_type, **sub_mod.kwargs)
            setattr(
                top.submodules,
                f"{sub_mod.name}.verilog",
                verilog,
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
