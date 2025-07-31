module AES_main(
    input  [127:0] plaintext,
    input  [127:0] round_key0,  // Initial round key
    input  [127:0] round_key1,  // Round 1 key (for example)
    output [127:0] ciphertext
);

    wire [127:0] state_pre;      // Output after pre_round (AddRoundKey)
    wire [127:0] state_subbytes;
    wire [127:0] state_shiftrows;
    wire [127:0] state_mixcolumns;
    wire [127:0] state_final;

    // Initial AddRoundKey (pre-round)
    Pre_round pre_round (
        .data(plaintext),
        .key(round_key0),
        .out(state_pre)
    );

    // SubBytes
    SubByte sb (
        .in(state_pre),
        .out(state_subbytes)
    );

    // ShiftRows
    ShiftRow sr (
        .data_in(state_subbytes),
        .data_out(state_shiftrows)
    );

    // MixColumns
    MixCol mc (
        .state_in(state_shiftrows),
        .state_out(state_mixcolumns)
    );

    // AddRoundKey (round 1)
    AddRoundKey ark (
        .data(state_mixcolumns),
        .key(round_key1),
        .out(state_final)
    );

    assign ciphertext = state_final;

endmodule