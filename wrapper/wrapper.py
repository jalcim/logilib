#!/usr/bin/env python3

import datetime
from os import environ

import amaranth as am
from amaranth.back.rtlil import convert_fragment
from amaranth.hdl.ir import Fragment

ALLOWED_PARAMS = {
    # must be updated with each module_type
    "gate_and": ["p_WAY", "p_WIRE"],
    "gate_or": ["p_WAY", "p_WIRE"],
    "gate_xor": ["p_WAY", "p_WIRE"],
    "gate_not": ["p_WIRE"],
    "gate_nand": ["p_WAY", "p_WIRE"],
    # new cells types must be added above this
    # les cells complexe auront d'autres parametres
    "default": ["p_WAY", "p_WIRE"],  # define defaut required parameters
}


class Module(am.Elaboratable):  # this is a recursive Element

    unique_id = 0  # auto increment
    data: dict = {}
    name = "default"
    submodules_list: list = []

    reg_in = False
    reg_out = False

    def __init__(self, module_type: str = "default", **kwargs):
        self.data = kwargs
        self.name = module_type + "_" + str(Module.unique_id)
        self.module_type = module_type
        self.ports: list = []
        # nothing below increment
        Module.unique_id += 1

    def check_module_type(self, module_type: str, params: dict):
        required_parameters = (
            ALLOWED_PARAMS[module_type]
            if module_type in ALLOWED_PARAMS.keys()
            else ALLOWED_PARAMS["default"]
        )
        for req_param in required_parameters:
            if req_param not in params.keys():
                raise Exception(
                    f"'{module_type}' module type must explicit "
                    f"'{req_param}' parameter."
                )

    def init_sig(self, sig_name: str):
        # auto init signal with correct size
        value = None
        if sig_name == "i_in":
            # les cells complexe pouront avoir des entrees
            # differentes et d'autres parametres
            if self.module_type in [
                "gate_or",
                "gate_and",
                "gate_nand",
                "gate_nor",
                "gate_xor",
                "gate_xnor",
            ]:
                value = am.Signal(self.data["p_WAY"] * self.data["p_WIRE"])
            elif self.module_type in ["gate_buf", "gate_not"]:
                value = am.Signal(self.data["p_WIRE"])
        elif sig_name == "o_out":
            # les cells complexe pouront avoir des
            # sorties differentes et d'autres parametres
            if self.module_type in [
                "gate_or",
                "gate_and",
                "gate_nand",
                "gate_nor",
                "gate_xor",
                "gate_xnor",
                "gate_buf",
                "gate_not",
            ]:
                value = am.Signal(self.data["p_WIRE"])
        if value is not None:
            self.set(sig_name, value)

    def add_submodules(self, new_modules: list):
        for mod in new_modules:
            self.submodules_list.append(mod)

    def clean_submodules(self):
        # for i in range(0, len(self.submodules_list)):
        #     del self.submodules_list[i]
        for mod in self.submodules_list:
            del mod

    def get(self, key: str):
        return self.data.get(key)

    def set(self, key: str, value):
        self.data[key] = value

    def write_rtlil_file(self):
        platform = None
        emit_src = True
        strip_internal_attrs = False
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

    def finish_prefab(self, recursive=False):
        self.params = {}
        for key, value in self.data.items():
            if key[0:2] in ["p_"]:
                self.params[key] = value

        # enregistrement des ports des submodules dans les ports du père
        # ici ?

    def elaborate(self, platform):
        # SEUL LE TOP APPELLE CETTE FONCTION
        # car seul le top est un module
        # les "gate_XXX" sont des cells pas des modules ! c'est a dire
        # des composants primitif de bas niveau (abstraction materiel)
        # les modules par contre peuvent contenir d'autres modules, qui
        # contiennent eux des cells !
        top = am.Module()
        for sub_mod in self.submodules_list:
            verilog = am.Instance(sub_mod.module_type, **sub_mod.data)
            setattr(
                top.submodules,
                f"{sub_mod.name}.verilog",
                verilog,
            )
            # ou là ?
            print("module name", sub_mod.name)
            for key in sub_mod.data.keys():
                if key[0:2] in ["i_", "o_"] or key[0:3] in ["io_"]:
                    if sub_mod.reg_in is False and sub_mod.reg_out is False:
                        print("no port to reg")
                    elif sub_mod.reg_in is False:
                        if key[0:2] in ["o_"]:
                            print("port reg", key)
                            self.ports.append(sub_mod.data.get(key))
                    elif sub_mod.reg_out is False:
                        if key[0:2] in ["i_"]:
                            print("port reg", key)
                            self.ports.append(sub_mod.data.get(key))
                    else:  # io_ tombe ici (actuellement non geré)
                        print("port reg", key)
                        self.ports.append(sub_mod.data.get(key))
        return top

    # DEBUG
    # ajout du nom du module inutilisé
    # UnusedElaboratable: Module() NOM_DU_MODULE created but never used
    def __repr__(self):
        return self.__class__.__name__ + "() " + self.name


if __name__ == "__main__":
    # exemple 2 : modules reliés dans un top

    # first, declare elements
    # cells : composants primitifs de bas niveau (abstraction matérielle)
    top_mod1 = Module("gate_and", p_WAY=2, p_WIRE=1)  # cells
    top_mod2 = Module("gate_and", p_WAY=2, p_WIRE=1)  # cells
    top_mod3 = Module("gate_and", p_WAY=2, p_WIRE=1)  # cells
    top_mod4 = Module("gate_not", p_WIRE=1)  # cells

    # module herité des ports de ses enfants
    # si ils sont enregistrés (reg_in/reg_out)
    top = Module("top")  # module (peut en contenir d'autres)

    # plug
    # les cells out les modules sous-jacents
    # les deux sont ajoutés de la même maniere
    top.add_submodules([top_mod1, top_mod2, top_mod3, top_mod4])

    # now we have to rely some entries
    top_mod1.set("p_WAY", 2)
    top_mod1.set("p_WIRE", 1)
    top_mod2.set("p_WAY", 2)
    top_mod2.set("p_WIRE", 1)
    top_mod3.set("p_WAY", 2)
    top_mod3.set("p_WIRE", 1)
    top_mod4.set("p_WIRE", 1)

    # register ports of submodules on top modules
    top_mod1.reg_in = True
    top_mod1.reg_out = False
    # level_top_in
    top_mod2.reg_in = True
    top_mod2.reg_out = False
    # level_top_in
    top_mod3.reg_in = False
    top_mod3.reg_out = False
    # level_intern
    top_mod4.reg_in = False
    top_mod4.reg_out = True
    # level_top_out

    # here, we have to rely all elements correctly, AFTER initialisation
    # l'ordre d'initialisation est importante !
    # "o_out" ne doit JAMAIS se trouver avant "i_in"
    # cet ordre est susceptible de varier sur les cells complexes
    top_mod1.init_sig("i_in")
    top_mod1.init_sig("o_out")
    top_mod2.init_sig("i_in")
    top_mod2.init_sig("o_out")
    top_mod3.set("i_in", am.Cat(top_mod1.get("o_out"), top_mod2.get("o_out")))
    top_mod3.init_sig("o_out")
    top_mod4.set("i_in", top_mod3.get("o_out"))
    top_mod4.init_sig("o_out")

    # finally
    top.write_rtlil_file()
