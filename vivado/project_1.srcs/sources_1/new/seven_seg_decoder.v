// File: seven_seg_decoder.v
// This module decodes a 4-bit binary input to 7-segment display output.
// It supports numbers 0 to 9.
// When enabled, the corresponding 7-segment code is output, otherwise, all segments are off.

// Copyright 2023 by Ahmed Allam, Kirollos Ehab, Eslam Tawfik, and Hussien ElAzhary
// License: MIT

// Coding practices based on guidelines available at:
// https://github.com/shalan/verilog_coding_guidelines

`timescale 1ns / 1ps
`default_nettype none

module seven_seg_decoder(
    input wire en,          // Enable signal
    input wire [3:0] num,   // 4-bit binary input
    output reg [6:0] seg    // 7-segment display output
);

    always @ (num or en) begin
        if (en) begin
            case(num)
                4'd0: seg = 7'b1000000;  // When num = 0
                4'd1: seg = 7'b1111001;  // When num = 1
                4'd2: seg = 7'b0100100;  // When num = 2
                4'd3: seg = 7'b0110000;  // When num = 3
                4'd4: seg = 7'b0011001;  // When num = 4
                4'd5: seg = 7'b0010010;  // When num = 5
                4'd6: seg = 7'b0000010;  // When num = 6
                4'd7: seg = 7'b1111000;  // When num = 7
                4'd8: seg = 7'b0000000;  // When num = 8
                4'd9: seg = 7'b0010000;  // When num = 9
                default: seg = 7'b1111111; // Default: All segments off
            endcase
        end else begin
            seg = 7'b1111111;  // If not enabled, turn off all segments
        end
    end
endmodule
