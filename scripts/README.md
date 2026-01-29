# Scripts

Outils d'automatisation pour la compilation, synthèse et tests.

## Scripts Shell

| Script | Description |
|--------|-------------|
| `yosys.sh` | Synthèse Yosys → génère `synth/{verilog,spice,rtlil}/` |
| `icarus.sh` | Compile les testbenches Verilog → `bin/` |
| `lib.sh` | Concatène les sources en un seul `lib.v` |
| `run_tests.sh` | Lance les tests co-simulation (8 threads) |

## Synthèse Yosys (yosys/)

Scripts TCL modulaires appelés par `yosys.sh`.

Point d'entrée : `all.tcl` avec paramètres `WAY=2`, `WIRE=32`.

## Manager GUI (manager/)

Interface GTK3 pour piloter le projet.

```bash
python3 scripts/manager/manager.py
```

**Boutons** : Build, Build Advanced, Cosimulation, Simulation

**Dépendances** : `python3-gi`, `gtk3`
