from amaranth import Elaboratable, Instance, Module

class Gate_xor(Elaboratable):
    def __init__(self, out, in1, in2):
        self.out = clk
        self.in1 = cnt
        self.in2 = cnt

    def elaborate(self, platform):
        m = Module()
        m.submodules.verilog_counter = Instance(
            "gate_xor",
            i_in1 = self.in1,
            i_in2 = self.in2,
            o_out = self.out
        )
        return m
