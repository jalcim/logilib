module and4(a,b,c,d, s);
   input a,b,c,d;
   output s;
   assign s =  a & b & c & d;
endmodule // and4

module and5(a,b,c,d,e, s);
   input a,b,c,d,e;
   output      s;
   assign s = a & b & c & d & e;
endmodule // and5

module multigate_and8(bus, s);
   input [7:0] bus;
   output      s;
   assign s = bus[0] & bus[1] & bus[2] & bus[3]
	      & bus[4] & bus[5] & bus[6] & bus[7];
endmodule // and8

module or16(bus, s);
   input [15:0] bus;
   output 	s; 	
   assign s = bus[0] | bus[1] | bus[2] | bus[3]
	      | bus[4] | bus[5] | bus[6] | bus[7]
	      | bus[8] | bus[9] | bus[10] | bus[11]
	      |  bus[12] | bus[13] | bus[14] | bus[15];
endmodule // or16
