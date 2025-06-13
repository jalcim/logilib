#!/bin/sh
cat `find src/ -name "*.v"` > full.v;sed -i '/^ *`include/d' lib.v
