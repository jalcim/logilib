module and4(bus, s);
   input [3:0] bus;
   output      s;
   assign s = bus[0] & bus[1] & bus[2] & bus[3];
endmodule; // and4

module and8(bus, s);
   input [7:0] bus;
   output      s;
   assign s = bus[0] & bus[1] & bus[2] & bus[3]
	      & bus[4] & bus[5] & bus[6] & bus[7];
endmodule; // and8
