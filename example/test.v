module test;
   reg [7:0] a, b;
   wire [7:0] sum;
   wire cout;

   addX #(.WIRE(8)) adder(.a(a), .b(b), .cin(1'b0), .out(sum), .cout(cout));

   initial begin
      a = 8'd42; b = 8'd58;
      #10;
      $display("42 + 58 = %d", sum);
   end
endmodule
