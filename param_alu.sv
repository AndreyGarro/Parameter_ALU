module param_alu #(parameter n = 3) (input logic [n-1:0] a, b, 
												 input logic [3:0] s,
												 output logic [n-1:0] c,
												 output logic zero, negative, _carry, overflow);
	logic [n-1:0] not_b;
	logic [n-1:0] b_mux;
	logic [n-1:0] sum;
	logic [n-1:0] and_result;
	logic [n-1:0] or_result;
	logic [n-1:0] xor_result;
	logic [n-1:0] lrs_result;
	logic [n-1:0] lls_result;
	logic [n-1:0] ars_result;
	logic [n-1:0] als_result;
	logic [n-1:0] cs_result;
	logic cout;
	not_gate #(n) not_op(b, not_b);
	multiplexer #(n) b_multiplexer(b, not_b, s[0], b_mux);
	fulladder #(n) adder(a, b_mux, s[0], sum, cout);
	and_gate #(n) and_op(a, b, and_result);
	or_gate #(n) or_op(a, b, or_result);
	xor_gate #(n) xor_op(a, b, xor_result);
	logic_right_shifter #(n) logic_right_shift_op(a, b, lrs_result);
	logic_left_shifter #(n) logic_left_shift_op(a, b, lls_result);
	aritmetic_right_shifter #(n) aritmetic_right_shift_op(a, b, ars_result);
	aritmetic_left_shifter #(n) aritmetic_left_shift_op(a, b, als_result);
	circular_shifter #(n) circular_shift_op(a, cs_result);
	
	multiplexer_16_to_1 #(n) op_selector(and_result, or_result, xor_result, lls_result,
													 lrs_result, cs_result, 0, 0,
													 sum, sum, als_result, ars_result,
													 0, 0, 0, 0, 
													 s, c);
	
	flag_zero #(n) zero_conditions(c, zero);
	flag_negative negative_conditions(c[n-1], s[3], negative);
	flag_carry carry_conditions(cout, s, _carry);
	flag_overflow overflow_conditions(a[n-1], b[n-1], sum[n-1], s, overflow);

endmodule
