module hex7seg(display, inputHex, enable);

	output logic [6:0] display;
	input logic [3:0] inputHex;
	input logic enable;

	deco_7 deco(display, inputHex, enable);

endmodule
