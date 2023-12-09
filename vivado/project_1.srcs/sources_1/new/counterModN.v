// File: counterModN.v
// This module implements a modular counter with configurable parameters.
// The counter increments with each clock cycle when enabled and resets when the reset signal is high.

// Copyright 2023 by Ahmed Allam, Kirollos Ehab, Eslam Tawfik, and Hussien ElAzhary
// License: MIT

// Coding practices based on guidelines available at:
// https://github.com/shalan/verilog_coding_guidelines

`timescale 1ns / 1ps
`default_nettype none

module counterModN #(
    parameter X = 5,  // Width of the counter
    parameter N = 20  // Maximum count value
) (
    input wire clk,      // Clock signal
    input wire en,       // Enable signal for the counter
    input wire reset,    // Asynchronous reset signal
    output reg [X-1:0] count // Counter output
);

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            count <= 0;
        end else if (en) begin
            if (count == N - 1) begin
                count <= 0;
            end else begin
                count <= count + 1;
            end
        end
    end

endmodule
