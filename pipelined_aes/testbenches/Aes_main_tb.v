`timescale 1ns / 1ps

module Aes_main_tb;

    reg [127:0] plaintext;
    reg [127:0] round_key0;
    reg [127:0] round_key1;
    wire [127:0] ciphertext;

    // Instantiate the AES_main module
    AES_main uut (
        .plaintext(plaintext),
        .round_key0(round_key0),
        .round_key1(round_key1),
        .ciphertext(ciphertext)
    );

    initial begin
        // Example plaintext and round keys (you can replace these with test vectors)
        plaintext   = 128'h3243f6a8885a308d313198a2e0379999;
        round_key0  = 128'h2b7e151628aed2a6abf7158809cf4f3c;
        round_key1  = 128'ha0fafe1788542cb123a339392a6c7605;

        // Wait for logic to process
        #10;

        // Display results
        $display("Plaintext     : %h", plaintext);
        $display("Round Key 0   : %h", round_key0);
        $display("Round Key 1   : %h", round_key1);
        $display("Ciphertext    : %h", ciphertext);

        // Finish simulation
        #10;
        $finish;
    end

endmodule
