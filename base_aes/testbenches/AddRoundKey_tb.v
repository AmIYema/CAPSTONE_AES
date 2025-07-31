`timescale 1ns / 1ps

module AddRoundKey_tb;

reg [127:0] in;
reg [127:0] key;
wire [127:0] out;	


AddRoundKey m (in, out, key);

initial begin
	$monitor("input= %H, output= %h, key = %h", in, out, key);
	in = 128'h046681e5e0cb199a48f8d37a2806264c;
	key = 128'ha0fafe1788542cb123a339392a6c7605;
end
endmodule

//data is read column down and so is key and output