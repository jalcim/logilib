# Getting Started

## Create a project

### 1. Project structure

```
my_project/
├── my_project.core
└── my_design.v
```

### 2. Core file

```yaml
CAPI=2:
name: user:project:my_project:1.0.0
description: My project using logilib

filesets:
  rtl:
    files:
      - my_design.v
    file_type: verilogSource
    depend:
      - jalcim:logilib:logilib

targets:
  sim:
    filesets:
      - rtl
    toplevel: my_design
    flow: sim
    flow_options:
      tool: icarus
      iverilog_options:
        - -Isrc/jalcim_logilib_logilib_1.0.0
        - -PRECURSIVE_MOD_LIMIT=1000
```

### 3. Verilog code

```verilog
module my_design;
   reg [7:0] a, b;
   wire [7:0] sum;
   wire cout;

   // Instantiate logilib modules directly (no include)
   addX #(.WIRE(8)) adder(.a(a), .b(b), .cin(1'b0), .out(sum), .cout(cout));

   initial begin
      a = 8'd42; b = 8'd58;
      #10;
      $display("42 + 58 = %d", sum);
   end
endmodule
```

### 4. Run

```bash
fusesoc library add my_project .
fusesoc run --target=sim user:project:my_project
```

## Example

See [example/](https://gitlab.com/jalcim/logilib/-/tree/master/example) for a complete working example.
