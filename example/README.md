# logilib usage example

## Requirements

- [FuseSoC](https://github.com/olofk/fusesoc): `pip install fusesoc`
- [Icarus Verilog](http://iverilog.icarus.com/)

## Install logilib

```bash
fusesoc library add logilib https://github.com/music/logilib
```

## Create your project

### 1. `.core` file

```yaml
CAPI=2:
name: music:music:my_project:1.0.0
description: My project

filesets:
  rtl:
    files:
      - my_file.v
    file_type: verilogSource
    depend:
      - music:music:logilib

targets:
  sim:
    filesets:
      - rtl
    toplevel: my_module
    flow: sim
    flow_options:
      tool: icarus
      iverilog_options:
        - -Isrc/music_music_logilib_1.0.0
        - -PRECURSIVE_MOD_LIMIT=1000
```

### 2. Verilog code

Instantiate logilib modules directly (no `include`):

```verilog
module my_module;
   addX #(.WIRE(8)) adder(.a(a), .b(b), .cin(cin), .out(sum), .cout(cout));
   mux #(.WAY(2), .WIRE(8)) mux_inst(.out(out), .in({in1, in0}), .ctrl(sel));
endmodule
```

### 3. Run

```bash
fusesoc library add my_project .
fusesoc run --target=sim music:music:my_project
```

## Available modules

| Module | Description | Parameters |
|--------|-------------|------------|
| `gate_and`, `gate_or`, `gate_xor`... | Logic gates | WAY, WIRE |
| `mux` | Multiplexer | WAY, WIRE |
| `demux` | Demultiplexer | WAY, WIRE |
| `addX` | N-bit adder | WIRE |
| `Dlatch`, `Dflipflop` | Memory elements | WAY, WIRE |
| `tensor` | Convolution accelerator | - |

See `src/` for the full list.
