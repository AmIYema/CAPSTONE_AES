`timescale 1ns / 1ps

module SubByte(in, out);
  input [127:0] in;
  output wire [127:0] out;

  genvar i;
  generate
    for (i = 0; i < 128; i = i + 8) begin : sub_Bytes
      SBox s(in[i +: 8], out[i +: 8]);
    end
  endgenerate
endmodule
