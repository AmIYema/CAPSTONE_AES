`timescale 1ns/1ps

module KeyGen_tb;

    reg [127:0] key;
    wire [1407:0] w;

    KeyGen dut (
        .key(key),
        .w(w)
    );

    integer i;
    reg [31:0] w_expanded [0:43];  // 44 words

    initial begin
        key = 128'h2b7e151628aed2a6abf7158809cf4f3c;
        #1;

        $display("Expanded AES-128 key words:");
        for (i = 0; i < 44; i = i + 1) begin
            w_expanded[i] = w[1407 - i*32 -: 32];
            $display("w[%0d] = %h", i, w_expanded[i]);
        end

        $finish;
    end
endmodule
