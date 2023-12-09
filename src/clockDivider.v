// File: clockDivider.v
// This module implements a clock divider.
// The division factor is parameterizable.

// Copyright 2023 by Ahmed Allam, Kirollos Ehab, Eslam Tawfik, and Hussien ElAzhary
// License: MIT

// Coding practices based on guidelines available at:
// https://github.com/shalan/verilog_coding_guidelines

`timescale 1ns / 1ps
`default_nettype none

module clockDivider #(
    parameter N = 500_000  // Division factor parameter, default set to 500,000
)(
    input wire clk,       // Clock input
    input wire en,        // Enable signal
    input wire rst,       // Asynchronous reset
    output reg clk_out    // Divided clock output
);

    wire [31:0] count;    // Counter value

    counterModN #(.X(32), .N(N)) counterMod (
        .clk(clk),
        .reset(rst),
        .en(en),
        .count(count)
    );

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            clk_out <= 1'b0;
        end else if (count == N - 1) begin
            clk_out <= ~clk_out;
        end
    end

endmodule
