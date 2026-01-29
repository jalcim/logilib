# Formal Verification

Property-based verification using SymbiYosys.

## Requirements

```bash
# Install SymbiYosys and solvers
# See: https://symbiyosys.readthedocs.io/en/latest/install.html

# Fedora (from source)
git clone https://github.com/YosysHQ/sby
cd sby && pip install .

# Solvers
sudo dnf install yices z3
```

## Run Verification

```bash
cd veriform/alu/arithm
sby -f addX.sby
```

## Verified Modules

| Module | Properties | Status |
|--------|------------|--------|
| addX | Correctness, overflow | Verified |
| mux | Selection, completeness | Verified |
| demux | Routing, mutual exclusion | Verified |

## Structure

```
veriform/
├── alu/
│   └── arithm/
│       ├── addX.sby         # Adder properties
│       └── addX.sv          # SystemVerilog assertions
└── routing/
    ├── mux.sby              # Mux properties
    └── demux.sby            # Demux properties
```

## Writing Properties

### SBY Configuration File

```sby
# addX.sby
[options]
mode prove
depth 20

[engines]
smtbmc z3

[script]
read -formal addX.v
read -formal addX_props.sv
prep -top addX

[files]
../../src/alu/arithm/addX.v
addX_props.sv
```

### SystemVerilog Assertions

```systemverilog
// addX_props.sv
module addX_props #(parameter WIRE = 8) (
    input [WIRE-1:0] a, b,
    input cin,
    input [WIRE-1:0] out,
    input cout
);
    // Property: Output equals sum
    assert property (
        {cout, out} == (a + b + cin)
    );

    // Property: Zero + Zero = Zero
    assert property (
        (a == 0 && b == 0 && cin == 0) |-> (out == 0 && cout == 0)
    );

    // Property: Commutativity
    wire [WIRE-1:0] out_ba;
    wire cout_ba;
    addX #(.WIRE(WIRE)) dut_ba (.a(b), .b(a), .cin(cin), .out(out_ba), .cout(cout_ba));

    assert property (out == out_ba && cout == cout_ba);

endmodule
```

## Verification Results

Successful verification proves:
- Correctness for all possible inputs
- No corner case bugs
- Mathematical properties hold

## Location

`veriform/`
