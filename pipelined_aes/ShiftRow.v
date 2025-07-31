`timescale 1ns / 1ps

module ShiftRow(data_in, data_out);
	input [0:127] data_in;
	output [0:127] data_out;
	
	// First row (r = 0) is not shifted
	assign data_out[0+:8] = data_in[0+:8];
	assign data_out[32+:8] = data_in[32+:8];
	assign data_out[64+:8] = data_in[64+:8];
	assign data_out[96+:8] = data_in[96+:8];
	
	// Second row (r = 1) is cyclically left shifted by 1 offset
	assign data_out[8+:8] = data_in[40+:8];
	assign data_out[40+:8] = data_in[72+:8];
	assign data_out[72+:8] = data_in[104+:8];
	assign data_out[104+:8] = data_in[8+:8];
	
	// Third row (r = 2) is cyclically left shifted by 2 offsets
	assign data_out[16+:8] = data_in[80+:8];
	assign data_out[48+:8] = data_in[112+:8];
	assign data_out[80+:8] = data_in[16+:8];
	assign data_out[112+:8] = data_in[48+:8];
	
	// Fourth row (r = 3) is cyclically left shifted by 3 offsets
	assign data_out[24+:8] = data_in[120+:8];
	assign data_out[56+:8] = data_in[24+:8];
	assign data_out[88+:8] = data_in[56+:8];
	assign data_out[120+:8] = data_in[88+:8];

endmodule
