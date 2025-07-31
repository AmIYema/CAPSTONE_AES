`timescale 1ns / 1ps

module tb_aes128_encrpt_pipelined;

    // Inputs
    reg clk;
    reg rst_n;
    reg [127:0] plaintext;
    reg [127:0] cipher_key;

    // Output
    wire [127:0] ciphertext;

    // Instantiate DUT
    AES_128_Encrypt uut (
        .clk(clk),
        .rst_n(rst_n),
        .plaintext(plaintext),
        .cipher_key(cipher_key),
        .ciphertext(ciphertext)
    );

    // Clock generation (10 ns period = 100 MHz)
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    // Test sequence
    initial begin
        $timeformat(-9, 1, " ns", 6);
        $display("===== AES-128 Pipelined Testbench =====");

        // Initialize
        rst_n = 0;
        plaintext = 0;
        cipher_key = 0;

        // Apply reset
        #20;
        rst_n = 1;

        // Test Vector (from AES standard FIPS-197 example)
        // Plaintext: 00112233445566778899aabbccddeeff
        // Key:       000102030405060708090a0b0c0d0e0f
        // Expected Ciphertext: 69c4e0d86a7b0430d8cdb78070b4c55a

        @(posedge clk);
        plaintext = 128'h00112233445566778899aabbccddeeff;
        cipher_key = 128'h000102030405060708090a0b0c0d0e0f;

        // Wait for pipeline to produce result (11 cycles latency)
        repeat (11) @(posedge clk);

        $display("Time = %t | Ciphertext = %h", $time, ciphertext);
        if (ciphertext == 128'h69c4e0d86a7b0430d8cdb78070b4c55a)
            $display("✅ Test Passed!");
        else
            $display("❌ Test Failed! Expected 69c4e0d86a7b0430d8cdb78070b4c55a");

        // Optionally feed multiple plaintexts back-to-back (to test throughput)
        @(posedge clk);
        plaintext = 128'h00000000000000000000000000000000;  // Random test vector
        cipher_key = 128'h00000000000000000000000000000000;

        // Run long enough to flush pipeline
        repeat (20) @(posedge clk);

        $finish;
    end

    // Monitor output every cycle
    always @(posedge clk) begin
        $display("Time = %t | Plaintext = %h | Ciphertext = %h", $time, plaintext, ciphertext);
    end

endmodule