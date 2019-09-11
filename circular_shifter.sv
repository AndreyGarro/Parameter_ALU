module circular_shifter #(parameter n = 8) (input logic [n-1:0] a, output logic [n-1:0] s); 
	
	assign s = {a[0], a[n-1:1]};

endmodule
