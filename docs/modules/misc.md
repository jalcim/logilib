# Miscellaneous Modules

Additional utility modules.

---

## complex_gate

### NAME
complex_gate - AOI/OAI complex gate

### SYNOPSIS
```verilog
gate_ao instance_name (.out(result), .in(inputs));
gate_oa instance_name (.out(result), .in(inputs));
```

### DESCRIPTION
AND-OR-Invert (AOI) and OR-AND-Invert (OAI) complex gates. These are commonly used in CMOS logic for efficient implementation.

**gate_ao (AOI):** `out = ~((a & b) | c)`
**gate_oa (OAI):** `out = ~((a | b) & c)`

### PORTS
| Port | Direction | Width | Description |
|------|-----------|-------|-------------|
| in | input | 3 | Input signals {c, b, a} |
| out | output | 1 | Complex gate output |

### EXAMPLE
```verilog
wire a, b, c, result;
gate_ao aoi21 (.out(result), .in({c, b, a}));
// result = ~((a & b) | c)
```

---

## multi_or

### NAME
multi_or - Multiple parallel OR gates

### SYNOPSIS
```verilog
multi_or #(.NB_GATE(n), .WAY(w), .WIRE(b)) instance_name (.out(results), .in(inputs));
```

### DESCRIPTION
Instantiates NB_GATE parallel OR gates, each with WAY inputs of WIRE bits.

### PARAMETERS
| Parameter | Default | Description |
|-----------|---------|-------------|
| NB_GATE | 1 | Number of OR gates |
| WAY | 2 | Inputs per gate |
| WIRE | 1 | Bit width |

### PORTS
| Port | Direction | Width | Description |
|------|-----------|-------|-------------|
| in | input | NB_GATE × WAY × WIRE | All inputs |
| out | output | NB_GATE × WIRE | All outputs |

---

Location: `src/primitive/gate/complex/` and `src/primitive/gate/multi/`
