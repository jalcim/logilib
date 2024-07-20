#!/bin/sh

test_bus_axi_lite()
{
    TEST_bus_axi_lite="test/bus/axi_lite"
    BIN_bus_axi_lite="bin/bus/axi_lite"

    mkdir -p $BIN_bus_axi_lite

    iverilog -o $BIN_bus_axi_lite/test_axi_lite_slave test/bus/axi_lite/slave_bench.v src/bus/axi_lite/slave.v src/bus/axi_lite/regs.v
    iverilog -o $BIN_bus_axi_lite/test_axi_lite_master test/bus/axi_lite/master_bench.v src/bus/axi_lite/master.v src/bus/axi_lite/slave.v src/bus/axi_lite/regs.v
}

test_bus_axi_lite
