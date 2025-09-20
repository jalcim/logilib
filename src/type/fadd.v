module fadd(input [31:0]  a,
	    input [31:0]  b,
	    output [31:0] result);

   // IEEE 754 decomposition
   wire [22:0] a_mantissa = a[22:0];
   wire [7:0]  a_exponent = a[30:23];
   wire	       a_sign = a[31];

   wire [22:0] b_mantissa = b[22:0];
   wire [7:0]  b_exponent = b[30:23];
   wire	       b_sign = b[31];

   // Compare exponents and determine which operand is larger
   wire [7:0] exp_diff = (a_exponent > b_exponent) ? (a_exponent - b_exponent) : (b_exponent - a_exponent);
   wire       swap = b_exponent > a_exponent;

   // Add implicit 1. to mantissas (normalized numbers)
   wire [23:0] a_mant_full = {1'b1, a_mantissa};
   wire [23:0] b_mant_full = {1'b1, b_mantissa};

   // Select larger and smaller operands
   wire [23:0] larger_mant = swap ? b_mant_full : a_mant_full;
   wire [23:0] smaller_mant = swap ? a_mant_full : b_mant_full;
   wire [7:0]  larger_exp = swap ? b_exponent : a_exponent;
   wire	       larger_sign = swap ? b_sign : a_sign;
   wire	       smaller_sign = swap ? a_sign : b_sign;

   // Align mantissas: shift smaller mantissa right by exponent difference
   // This ensures both numbers have the same exponent for addition
   wire [23:0] aligned_smaller = smaller_mant >> exp_diff;

   // Perform addition or subtraction based on signs:
   // Same signs: add mantissas (+3.5) + (+2.1) or (-3.5) + (-2.1)
   // Different signs: subtract mantissas (+3.5) + (-2.1) or (-3.5) + (+2.1)
   wire [24:0] mant_sum = (larger_sign == smaller_sign) ?
			  (larger_mant + aligned_smaller) :
			  (larger_mant - aligned_smaller);

   // Check if subtraction result is negative (smaller was actually larger)
   wire	       result_negative = (larger_sign != smaller_sign) && !mant_sum[24] && (mant_sum == 0);
   wire	       final_sign = result_negative ? smaller_sign : larger_sign;

   // Normalize result if overflow occurred:
   // If carry bit is set (25th bit), we have overflow like 11.xxxxx
   // Shift right by 1 position to get 1.xxxxx and increment exponent
   wire	       carry = mant_sum[24];
   wire [22:0] final_mant = carry ? mant_sum[23:1] : mant_sum[22:0];
   wire [7:0]  final_exp = carry ? (larger_exp + 1) : larger_exp;

   // Reconstruct IEEE 754 format
   assign result = {final_sign, final_exp, final_mant};

endmodule