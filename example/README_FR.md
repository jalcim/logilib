# Exemple d'utilisation de logilib

## Prérequis

- [FuseSoC](https://github.com/olofk/fusesoc) : `pip install fusesoc`
- [Icarus Verilog](http://iverilog.icarus.com/)

## Installation de logilib

```bash
fusesoc library add logilib https://gitlab.com/jalcim/logilib
```

## Créer votre projet

### 1. Fichier `.core`

```yaml
CAPI=2:
name: user:project:mon_projet:1.0.0
description: Mon projet

filesets:
  rtl:
    files:
      - mon_fichier.v
    file_type: verilogSource
    depend:
      - jalcim:logilib:logilib

targets:
  sim:
    filesets:
      - rtl
    toplevel: mon_module
    flow: sim
    flow_options:
      tool: icarus
      iverilog_options:
        - -Isrc/jalcim_logilib_logilib_1.0.0
        - -PRECURSIVE_MOD_LIMIT=1000
```

### 2. Code Verilog

Instanciez directement les modules logilib (pas d'`include`) :

```verilog
module mon_module;
   addX #(.WIRE(8)) adder(.a(a), .b(b), .cin(cin), .out(sum), .cout(cout));
   mux #(.WAY(2), .WIRE(8)) mux_inst(.out(out), .in({in1, in0}), .ctrl(sel));
endmodule
```

### 3. Lancer

```bash
fusesoc library add mon_projet .
fusesoc run --target=sim user:project:mon_projet
```

## Modules disponibles

| Module | Description | Paramètres |
|--------|-------------|------------|
| `gate_and`, `gate_or`, `gate_xor`... | Portes logiques | WAY, WIRE |
| `mux` | Multiplexeur | WAY, WIRE |
| `demux` | Démultiplexeur | WAY, WIRE |
| `addX` | Additionneur N-bits | WIRE |
| `Dlatch`, `Dflipflop` | Éléments mémoire | WAY, WIRE |
| `tensor` | Accélérateur convolution | - |

Voir `src/` pour la liste complète.
