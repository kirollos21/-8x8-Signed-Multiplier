// File: shift_right_register.v
// This module implements an 8-bit shift right register.
// It shifts the contents to the right when enabled and loads new data on a load signal.

// Copyright 2023 by Ahmed Allam, Kirollos Ehab, Eslam Tawfik, and Hussien ElAzhary
// License: MIT

// Coding practices based on guidelines available at:
// https://github.com/shalan/verilog_coding_guidelines

`timescale 1ns / 1ps
`default_nettype none

module shift_right_register(
    input wire clk,         // Clock input
    input wire load,        // Load signal
    input wire en,          // Enable signal for shifting
    input wire [7:0] Num,   // Input number to load
    output reg [7:0] Out    // Shifted output
);

    integer i;

    always @(posedge clk) begin
        if (load) begin
            Out <= Num;  // Load the input number when load signal is high
        end else if (en) begin
            // Shift right operation
            for (i = 7; i > 0; i = i - 1) begin
                Out[i - 1] <= Out[i];
            end
            Out[7] <= 1'b0;  // Set the MSB to 0 after shift
        end
    end

endmodule
