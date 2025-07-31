`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 17.07.2025 14:46:32
// Design Name: 
// Module Name: aes_top2
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module aes_top2(
    input  [127:0] plaintext0,
    input  [127:0] plaintext1,
    input  [127:0] cipher_key,
    output [127:0] ciphertext0,
    output [127:0] ciphertext1
);

    AES_128_Encrypt aes0 (
        .plaintext(plaintext0),
        .cipher_key(cipher_key),
        .ciphertext(ciphertext0)
    );

    AES_128_Encrypt aes1 (
        .plaintext(plaintext1),
        .cipher_key(cipher_key),
        .ciphertext(ciphertext1)


    );
endmodule
