# Icarus Verilog Tests

Behavioral simulation tests using Icarus Verilog.

## Requirements

```bash
# Fedora
sudo dnf install iverilog

# Ubuntu/Debian
sudo apt install iverilog
```

## Run All Tests

```bash
./scripts/icarus.sh
```

## Run Individual Tests

```bash
# Test a specific module
iverilog -o test.vvp test/routing/test_mux.v
vvp test.vvp

# With waveform output
iverilog -o test.vvp test/routing/test_mux.v
vvp test.vvp
gtkwave test.vcd
```

## Test Files

### ALU Tests

| Test | Module | Description |
|------|--------|-------------|
| `test_add.v` | add | 1-bit adder |
| `test_addX.v` | addX | N-bit adder |
| `test_cmp.v` | cmp | Comparator |
| `test_multX.v` | multX | Multiplier |
| `test_divmod2.v` | divmod2 | Division by 2 |
| `test_alu_logic.v` | sll, slt, sltu | Shift and compare |

### Memory Tests

| Test | Module | Description |
|------|--------|-------------|
| `test_Dlatch.v` | Dlatch | D latch |
| `test_Dlatch_rst.v` | Dlatch_rst | D latch with reset |
| `test_Dflipflop.v` | Dflipflop | D flip-flop |
| `test_Dflipflop_rst.v` | Dflipflop_rst | D flip-flop with reset |
| `test_JKlatchUP_rst.v` | JKlatch_rst | JK latch |

### Routing Tests

| Test | Module | Description |
|------|--------|-------------|
| `test_mux.v` | mux | Multiplexer |
| `test_demux.v` | demux | Demultiplexer |
| `test_encoder.v` | encoder | Binary encoder |
| `test_shuffle.v` | shuffle | Data shuffler |
| `test_replicator.v` | replicator | Signal replicator |

### Primitive Tests

| Test | Module | Description |
|------|--------|-------------|
| `test_gate.v` | gate_* | All gate types |
| `test_serial_gate.v` | serial_* | Serial implementations |
| `test_parallel_gate.v` | parallel_* | Parallel implementations |
| `test_complex_gate.v` | complex_gate | AOI/OAI gates |

### Other Tests

| Test | Module | Description |
|------|--------|-------------|
| `test_tensor.v` | tensor | Convolution accelerator |
| `test_cpt_bin.v` | cpt_bin | Binary counter |
| `master_bench.v` | axi4_master | AXI master |
| `slave_bench.v` | axi4_slave | AXI slave |

## Writing Tests

```verilog
`timescale 1ns/1ps

module test_example;
    reg [7:0] a, b;
    wire [7:0] result;

    // Instantiate DUT
    addX #(.WIRE(8)) dut (.a(a), .b(b), .cin(1'b0), .out(result), .cout());

    initial begin
        $dumpfile("test.vcd");
        $dumpvars(0, test_example);

        // Test vectors
        a = 8'd10; b = 8'd20; #10;
        if (result !== 8'd30) $display("FAIL: 10+20=%d", result);

        a = 8'd255; b = 8'd1; #10;
        if (result !== 8'd0) $display("FAIL: 255+1=%d", result);

        $display("Test complete");
        $finish;
    end
endmodule
```

## Location

`test/`
