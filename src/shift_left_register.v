// File: shift_left_register.v
// This module implements a shift left register.

// Copyright 2023 by Ahmed Allam, Kirollos Ehab, Eslam Tawfik, and Hussien ElAzhary
// License: MIT

// Coding practices based on guidelines available at:
// https://github.com/shalan/verilog_coding_guidelines

`timescale 1ns / 1ps
`default_nettype none

module shift_left_register(
    input wire        clk,    // Clock signal
    input wire        load,   // Load control signal
    input wire        en,     // Enable control signal
    input wire [7:0]  Num,    // 8-bit input number
    output reg [15:0] Out     // 16-bit output register
);

    integer i;

    // Shift left logic
    always @(posedge clk) begin
        if (load) begin
            // Load the input number with zero padding on left
            Out <= {8'b0, Num};
        end else if (en) begin
            // Shift left operation
            for (i = 15; i > 0; i = i - 1) begin
                Out[i] <= Out[i - 1];
            end
            Out[0] <= 1'b0;
        end
    end

endmodule
