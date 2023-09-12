test_gate()
{
    BIN_gate="bin/primitive/gate"
    TEST_gate="test/primitive/gate"

    mkdir $BIN_gate

    iverilog -o $BIN_gate/test_gate $TEST_gate/test_gate.v
#    $BIN_gate/test_gate > test_gate
}

test_primitive()
{
    mkdir bin/primitive

    test_gate
}

mkdir bin
test_primitive

