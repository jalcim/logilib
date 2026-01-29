# Amaranth Wrapper

Python/Amaranth HDL wrapper for logilib modules.

## Overview

The wrapper allows using logilib Verilog modules from Python using the Amaranth HDL framework.

## Requirements

```bash
python3 -m venv env
source env/bin/activate
pip install amaranth
```

## Structure

```
wrapper/amaranth/
├── Cell.py              # Base cell class
├── Module.py            # Module wrapper
├── Top.py               # Top-level integration
├── README.md            # Usage notes
└── test/                # Wrapper tests
```

## Usage

### Basic Cell

```python
from Cell import Cell

# Create a logilib cell instance
cell = Cell(
    name="gate_and",
    parameters={"WAY": 2, "WIRE": 8},
    ports={"in": 16, "out": 8}
)
```

### Module Integration

```python
from amaranth import *
from Module import LogilibModule

class MyDesign(Elaboratable):
    def elaborate(self, platform):
        m = Module()

        # Instantiate logilib module
        adder = LogilibModule("addX", WIRE=8)
        m.submodules.adder = adder

        # Connect signals
        m.d.comb += [
            adder.a.eq(self.input_a),
            adder.b.eq(self.input_b),
            self.result.eq(adder.out),
        ]

        return m
```

## Notes

From `README.md`:

> - Si cette erreur suivante s'affiche, c'est qu'un des signaux concaténé n'a pas été initialisé :
> ```python
> TypeError: Object None cannot be converted to an Amaranth value
> ```
> - Les signaux concaténé ne doivent pas être enregistrés dans les ports lors de l'élaboration (uniquement dans le `am.Instance`)

## Testing

```bash
cd wrapper/amaranth/test
python3 test_cell.py
```

## Location

`wrapper/amaranth/`
