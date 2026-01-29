# TODO / Roadmap

Work in progress and planned features.

## In Progress (`TODO/`)

### SRAM Module

Location: `TODO/sram/`

Static RAM implementation in progress:
- `TODO/sram/src/` - Source files
- `TODO/sram/test/` - Test files

### Sequential Register Decoder

Location: `TODO/src/sequential_regdec.v`

Sequential register decoder for memory addressing.

### 3-bit Counter Variant

Location: `TODO/bit_cpt3.v`, `TODO/test_bit_cpt3.v`

Alternative 3-bit counter implementation.

## Planned Features

### Short Term

- [ ] Complete SRAM module
- [ ] Add formal verification for more modules
- [ ] Expand AXI-Lite test coverage

### Medium Term

- [ ] SPI master/slave modules (schematics exist in `shema/spi/`)
- [ ] I2C interface
- [ ] UART module

### Long Term

- [ ] RISC-V compatible ALU
- [ ] Cache controller
- [ ] DMA controller

## Contributing

See [Contributing](../development/contributing.md) for how to help with these features.

## Notes

The `TODO/` directory contains experimental and work-in-progress code that is not yet part of the main library. These modules may:

- Be incomplete
- Have untested edge cases
- Change significantly before release

Do not depend on `TODO/` modules in production designs.
