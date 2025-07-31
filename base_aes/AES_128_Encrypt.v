module AES_128_Encrypt (
    input  wire        clk,
    input  wire        rst_n,
    input  wire [127:0] plaintext,
    input  wire [127:0] cipher_key,
    output reg  [127:0] ciphertext
);

    // Expanded round keys
    wire [1407:0] round_keys; // 44 words × 32 bits = 1408 bits

    // Key Expansion
    KeyGen keygen_inst (
        .key(cipher_key),
        .w(round_keys)
    );

    // ----------------------
    // Pipeline Registers
    // ----------------------
    reg [127:0] stage0; // after preround
    reg [127:0] stage1;
    reg [127:0] stage2;
    reg [127:0] stage3;
    reg [127:0] stage4;
    reg [127:0] stage5;
    reg [127:0] stage6;
    reg [127:0] stage7;
    reg [127:0] stage8;
    reg [127:0] stage9;
    reg [127:0] stage10;

    // ----------------------
    // Stage 0: Pre-round
    // ----------------------
    wire [127:0] preround_out;
    Pre_round pre_round (
        .data(plaintext),
        .key(round_keys[1407:1280]),
        .out(preround_out)
    );

    // ----------------------
    // Stage 1-9: AES Main Rounds
    // ----------------------
    wire [127:0] r1_out, r2_out, r3_out, r4_out, r5_out, r6_out, r7_out, r8_out, r9_out;

    AES_main round1 (.plaintext(stage0), .round_key0(128'h0), .round_key1(round_keys[1279:1152]), .ciphertext(r1_out));
    AES_main round2 (.plaintext(stage1), .round_key0(128'h0), .round_key1(round_keys[1151:1024]), .ciphertext(r2_out));
    AES_main round3 (.plaintext(stage2), .round_key0(128'h0), .round_key1(round_keys[1023:896]),  .ciphertext(r3_out));
    AES_main round4 (.plaintext(stage3), .round_key0(128'h0), .round_key1(round_keys[895:768]),   .ciphertext(r4_out));
    AES_main round5 (.plaintext(stage4), .round_key0(128'h0), .round_key1(round_keys[767:640]),   .ciphertext(r5_out));
    AES_main round6 (.plaintext(stage5), .round_key0(128'h0), .round_key1(round_keys[639:512]),   .ciphertext(r6_out));
    AES_main round7 (.plaintext(stage6), .round_key0(128'h0), .round_key1(round_keys[511:384]),   .ciphertext(r7_out));
    AES_main round8 (.plaintext(stage7), .round_key0(128'h0), .round_key1(round_keys[383:256]),   .ciphertext(r8_out));
    AES_main round9 (.plaintext(stage8), .round_key0(128'h0), .round_key1(round_keys[255:128]),   .ciphertext(r9_out));

    // ----------------------
    // Stage 10: Final Round
    // ----------------------
    wire [127:0] final_sb, final_sr, final_ark;

    SubByte final_sub (
        .in(stage9),
        .out(final_sb)
    );

    ShiftRow final_shift (
        .data_in(final_sb),
        .data_out(final_sr)
    );

    AddRoundKey final_add (
        .data(final_sr),
        .key(round_keys[127:0]),
        .out(final_ark)
    );

    // ----------------------
    // Pipeline Register Updates
    // ----------------------
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            stage0     <= 128'b0;
            stage1     <= 128'b0;
            stage2     <= 128'b0;
            stage3     <= 128'b0;
            stage4     <= 128'b0;
            stage5     <= 128'b0;
            stage6     <= 128'b0;
            stage7     <= 128'b0;
            stage8     <= 128'b0;
            stage9     <= 128'b0;
            stage10    <= 128'b0;
            ciphertext <= 128'b0;
        end else begin
            stage0     <= preround_out;
            stage1     <= r1_out;
            stage2     <= r2_out;
            stage3     <= r3_out;
            stage4     <= r4_out;
            stage5     <= r5_out;
            stage6     <= r6_out;
            stage7     <= r7_out;
            stage8     <= r8_out;
            stage9     <= r9_out;
            stage10    <= final_ark;
            ciphertext <= stage10;
        end
    end

endmodule