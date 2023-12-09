// File: debouncer.v
// This module implements a debouncing logic for signal stabilization.

// Copyright 2023 by Ahmed Allam, Kirollos Ehab, Eslam Tawfik, and Hussien ElAzhary
// License: MIT

// Coding practices based on guidelines available at:
// https://github.com/shalan/verilog_coding_guidelines

`timescale 1ns / 1ps
`default_nettype none

module debouncer(
    input wire clk,       // Clock signal
    input wire rst,     // Asynchronous reset
    input wire in,        // Input signal to debounce
    output wire out        // Debounced output signal
);

    reg q1, q2, q3;

    always @(posedge clk, posedge rst) begin
        if (rst) begin
            q1 <= 1'b0;
            q2 <= 1'b0;
            q3 <= 1'b0;
        end else begin
            q1 <= in;
            q2 <= q1;
            q3 <= q2;
        end 
    end

    assign out = (rst == 1'b1) ? 1'b0 : (q1 & q2 & q3);

endmodule
