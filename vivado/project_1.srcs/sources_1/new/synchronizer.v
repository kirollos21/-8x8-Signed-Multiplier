// File: synchronizer.v
// This module implements a two-stage flip-flop synchronizer for signal stabilization.
// Copyright 2023 by Ahmed Allam, Kirollos Ehab, Eslam Tawfik, and Hussien ElAzhary
// License: MIT
// Coding practices based on guidelines available at:
// https://github.com/shalan/verilog_coding_guidelines

`timescale 1ns / 1ps
`default_nettype none

module synchronizer(
    input wire clk,      // Clock input
    input wire rst,    // Asynchronous active low reset
    input wire in,       // Input signal to be synchronized
    output wire out      // Synchronized output signal
);

    reg q1, q2;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            q1 <= 1'b0;
            q2 <= 1'b0;
        end else begin
            q1 <= in;
            q2 <= q1;
        end
    end

    assign out = (rst) ? 1'b0 : q2;

endmodule
