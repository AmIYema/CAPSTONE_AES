`timescale 1ns / 1ps

module ShiftRow_tb;

reg [127:0] data_in;
wire [127:0] data_out;

// Instantiate the ShiftRow module
ShiftRow uut (
    .data_in(data_in),
    .data_out(data_out)
);

initial begin
    $monitor("Time = %0t | Input = %h | Output = %h", $time, data_in, data_out);
    
    data_in = 128'hac73cf7befc111df13b5d6b545235ab8;
    #10;
    
    $finish;
end

endmodule

//column major again
// read it column down then to the next column
