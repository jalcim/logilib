module rom (input [31:0] pc,
	    output [31:0] opcode);

   integer		 fd, code;
   reg [7:0]		 mem1, mem2, mem3, mem4;
   wire [31:0]		 instr;

   assign instr = {mem4, mem3, mem2, mem1};

   integer		 counter;
   reg [31:0]		 memory[0:1023];

   initial
     begin
	counter = 0;
	fd = $fopen("binary.raw", "r");
	code = 1;
	while (code)
	  begin
	     code = $fread(mem1, fd, 0, 1);
	     code = $fread(mem2, fd, 0, 1);
	     code = $fread(mem3, fd, 0, 1);
	     code = $fread(mem4, fd, 0, 1);

	     if (code)
	       begin
		  memory[counter] = instr;
		  counter = counter + 1;
	       end
	  end
     end

   assign opcode = memory[pc];

endmodule
