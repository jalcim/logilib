class counter(am.Elaboratable):
    def __init__(self, width, clk, cnt):
        self.width = width
        self.clk = clk
        self.cnt = cnt

    def elaborate(self, platform):
        m = am.Module()
        m.submodules.verilog_counter = am.Instance(
            "verilog_counter",
            p_WIDTH=self.width,
            i_clk=self.clk,
            o_cnt=self.cnt
        )
        return m
