`timescale 1ns / 1ps

module MixCol_tb;

    reg  [127:0] in;
    wire [127:0] out;

    // Instantiate the MixColumns module
    MixCol uut (
        .state_in(in),
        .state_out(out)
    );

    initial begin
        // Monitor output
        $monitor("Time = %0t | input = %h | output = %h", $time, in, out);

        // Apply test vector (can use known AES test vectors)
        in = 128'hd4bf5d30e0b452aeb84111f11e2798e5;
        #10;

        $finish;
    end

endmodule

//column major reading - goes down then shift to the next column
