`include "src/primitive/parallel_gate/parallel_and.v"
`include "src/primitive/parallel_gate/parallel_or.v"

module dec_LR(a, left, s);
   parameter WAY = 8;

   input [WAY-1:0] a;
   input       left;
   output [WAY-1:0] s;

   wire 	right;
   wire [WAY-2:0] 	line_right;
   wire [WAY-2:0] 	line_left;

   not not0(right, left);

/////////////////////////////////////////////////////////////

   parallel_and #(.WAY(WAY-1), .WIRE(2)) and_left(line_left,
						  a[WAY-1:1],
						  {WAY-1{letf}});

   parallel_and #(.WAY(WAY-1), .WIRE(2)) and_right(line_right,
						   a[WAY-2:0],
						   {WAY-1{right}});

//////////////////////////////////////////////////////////////////

   buf out0(s[0], line_left[0]);

   parallel_or #(.WAY(WAY-2), .WIRE(2)) out1_WAY(s[WAY-2:1],
						 line_left[WAY-2:1],
						 line_right[WAY-3:0]);

   buf out7(s[WAY-1], line_right[WAY-2]);
endmodule

/*
 gate_and and_left0 (line_left[0], a[1], left);
 gate_and and_left1 (line_left[1], a[2], left);
 gate_and and_left2 (line_left[2], a[3], left);
 gate_and and_left3 (line_left[3], a[4], left);
 gate_and and_left4 (line_left[4], a[5], left);
 gate_and and_left5 (line_left[5], a[6], left);
 gate_and and_left6 (line_left[6], a[7], left);

 gate_and and_right (line_right[0], a[0], right);
 gate_and and_right (line_right[1], a[1], right);
 gate_and and_right (line_right[2], a[2], right);
 gate_and and_right (line_right[3], a[3], right);
 gate_and and_right (line_right[4], a[4], right);
 gate_and and_right (line_right[5], a[5], right);
 gate_and and_right (line_right[6], a[6], right);
*/

/*
 gate_or  out1(s[1], line_left[1], line_right[0]);
 gate_or  out2(s[2], line_left[2], line_right[1]);
 gate_or  out3(s[3], line_left[3], line_right[2]);
 gate_or  out4(s[4], line_left[4], line_right[3]);
 gate_or  out5(s[5], line_left[5], line_right[4]);
 gate_or  out6(s[6], line_left[6], line_right[5]);
*/
