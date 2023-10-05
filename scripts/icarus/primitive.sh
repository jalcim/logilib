
#!/bin/sh

test_gate()
{
    TEST_gate="test/primitive/gate"
    BIN_gate="bin/primitive/gate"

    mkdir -p $BIN_gate

    iverilog  -o $BIN_gate/test_gate $TEST_gate/test_gate.v
    iverilog -o $BIN_gate/test_serial_gate $TEST_gate/test_serial_gate.v
    iverilog -o $BIN_gate/test_parallel_gate $TEST_gate/test_parallel_gate.v
}

test_complex_gate()
{
   TEST_complex_gate="test/primitive/complex_gate"
   BIN_complex_gate="bin/primitive/complex_gate"

   mkdir -p $BIN_complex_gate

   iverilog -o $BIN_complex_gate/test_complex_gate $TEST_complex_gate/test_complex_gate.v
}

test_primitive()
{
    test_gate
    test_complex_gate
}

test_primitive
