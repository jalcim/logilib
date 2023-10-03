yosys -p "read_verilog src/alu/arithm/addX.v;
          chparam -set "WIRE" ${1} addX; \
	  write_verilog out.v"
