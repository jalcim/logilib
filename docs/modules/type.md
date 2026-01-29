# Types

Floating-point storage and arithmetic modules.

---

## float

### NAME
float - IEEE 754 single-precision register

### SYNOPSIS
```verilog
float instance_name (
    .clk(clock), .rst(reset), .write(wr_en),
    .mantissa_in(mant_in), .exponent_in(exp_in), .sign_in(sign_in),
    .mantissa_out(mant_out), .exponent_out(exp_out), .sign_out(sign_out)
);
```

### DESCRIPTION
32-bit IEEE 754 single-precision floating-point register. Stores sign (1 bit), exponent (8 bits), and mantissa (23 bits) separately.

### PORTS
| Port | Direction | Width | Description |
|------|-----------|-------|-------------|
| clk | input | 1 | Clock |
| rst | input | 1 | Reset |
| write | input | 1 | Write enable |
| mantissa_in | input | 23 | Mantissa input |
| exponent_in | input | 8 | Exponent input |
| sign_in | input | 1 | Sign bit input |
| mantissa_out | output | 23 | Mantissa output |
| exponent_out | output | 8 | Exponent output |
| sign_out | output | 1 | Sign bit output |

### FORMAT
```
IEEE 754 Single Precision (32 bits):
┌────┬──────────┬───────────────────────┐
│ S  │ Exponent │       Mantissa        │
│ 1  │    8     │          23           │
└────┴──────────┴───────────────────────┘
 [31]  [30:23]         [22:0]
```

---

## double

### NAME
double - IEEE 754 double-precision register

### SYNOPSIS
```verilog
double instance_name (
    .clk(clock), .rst(reset), .write(wr_en),
    .mantissa_in(mant_in), .exponent_in(exp_in), .sign_in(sign_in),
    .mantissa_out(mant_out), .exponent_out(exp_out), .sign_out(sign_out)
);
```

### DESCRIPTION
64-bit IEEE 754 double-precision floating-point register. Stores sign (1 bit), exponent (11 bits), and mantissa (52 bits).

### PORTS
| Port | Direction | Width | Description |
|------|-----------|-------|-------------|
| clk | input | 1 | Clock |
| rst | input | 1 | Reset |
| write | input | 1 | Write enable |
| mantissa_in | input | 52 | Mantissa input |
| exponent_in | input | 11 | Exponent input |
| sign_in | input | 1 | Sign bit input |
| mantissa_out | output | 52 | Mantissa output |
| exponent_out | output | 11 | Exponent output |
| sign_out | output | 1 | Sign bit output |

### FORMAT
```
IEEE 754 Double Precision (64 bits):
┌────┬──────────┬──────────────────────────────────────┐
│ S  │ Exponent │              Mantissa                │
│ 1  │    11    │                 52                   │
└────┴──────────┴──────────────────────────────────────┘
 [63]  [62:52]              [51:0]
```

---

## fadd

### NAME
fadd - Floating-point adder

### DESCRIPTION
Floating-point addition unit (work in progress).

---

Location: `src/type/`
