# Synthesis

## Yosys

```bash
./scripts/yosys.sh
```

Output in `synth/`:
- `verilog/` - Synthesized Verilog
- `spice/` - SPICE netlists
- `rtlil/` - RTLIL intermediate

## FuseSoC

```bash
fusesoc run --target=synth jalcim:logilib:logilib
```

## Scripts

TCL scripts in `scripts/yosys/`:

| Script | Description |
|--------|-------------|
| `all.tcl` | Main entry point |
| `utils.tcl` | Helper functions |
| `alu/` | ALU synthesis |
| `memory/` | Memory synthesis |
| `primitive/` | Gate synthesis |
| `routing/` | Routing synthesis |

## Parameters

Default: `WAY=2`, `WIRE=32`

Modify in `scripts/yosys/all.tcl`:

```tcl
set WAY  2
set WIRE 32
```
