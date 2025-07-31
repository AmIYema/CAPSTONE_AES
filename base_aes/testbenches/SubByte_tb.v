`timescale 1ns / 1ps

module SubByte_tb;
  reg [127:0] in;
  wire [127:0] out;

  SubByte sb(in, out);

  initial begin
    $monitor("input= %h , output= %h", in, out);

    in = 128'h193de3bea0f4e22b9ac68d2ae9f84808;
    #10;
    $finish;
  end
endmodule

//output is read downt the column