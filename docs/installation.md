# Installation

## Requirements

- [FuseSoC](https://github.com/olofk/fusesoc)
- [Icarus Verilog](http://iverilog.icarus.com/) (simulation)
- [Verilator](https://www.veripool.org/verilator/) (optional, co-simulation)
- [Yosys](https://yosyshq.net/yosys/) (optional, synthesis)

## Install FuseSoC

```bash
pip install fusesoc
```

## Add logilib

```bash
fusesoc library add logilib https://gitlab.com/jalcim/logilib
```

## Verify

```bash
fusesoc core list | grep logilib
# jalcim:logilib:logilib:1.0.0
```

## Targets

| Target | Tool | Description |
|--------|------|-------------|
| `sim` | Icarus | Simulation |
| `sim_verilator` | Verilator | Co-simulation |
| `synth` | Yosys | Synthesis |
