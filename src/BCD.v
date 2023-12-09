// File: BCD.v
// Description: This module converts a binary number to its Binary-Coded Decimal (BCD) representation.
// Parameter W is the width of the input binary number.
// The output BCD has a width to accommodate the BCD representation.

// Copyright 2023 by Ahmed Allam, Kirollos Ehab, Eslam Tawfik, and Hussien ElAzhary
// License: MIT

// Coding practices based on guidelines available at:
// https://github.com/shalan/verilog_coding_guidelines

`timescale 1ns / 1ps
`default_nettype none

module BCD #(
    parameter W = 18  // Input width
)(
    input wire [W-1:0] bin,           // Binary input
    output reg [W+(W-4)/3:0] bcd      // BCD output
);

    integer i, j;

    always @(bin) begin
        // Initialize BCD with zeros
        for (i = 0; i <= W + (W-4)/3; i = i + 1) begin
            bcd[i] = 1'b0;
        end

        // Initialize with input vector
        bcd[W-1:0] = bin;

        // Iterate on structure depth
        for (i = 0; i <= W - 4; i = i + 1) begin
            // Iterate on structure width
            for (j = 0; j <= i / 3; j = j + 1) begin
                if (bcd[W - i + 4*j -: 4] > 4) begin                   
                    bcd[W - i + 4*j -: 4] = bcd[W - i + 4*j -: 4] + 4'd3;
                end
            end
        end
    end

endmodule
