// File: CU.v
// Description: Control Unit (CU) module for managing control signals in a digital system.
// This module uses input conditions to generate appropriate control signals.

// License: MIT
// Copyright 2023 by Ahmed Allam, Kirollos Ehab, Eslam Tawfik, and Hussien ElAzhary

// Coding practices based on guidelines available at:
// https://github.com/shalan/verilog_coding_guidelines


`timescale 1ns / 1ps
`default_nettype none

module CU(
    input wire b0,       // Input signal b0
    input wire z,        // Zero flag
    input wire load,     // Load signal
    output wire Psel,    // Control signal Psel
    output wire EP,      // Control signal EP
    output wire EA,      // Control signal EA
    output wire EB,      // Control signal EB
    output wire LA,      // Control signal LA
    output wire LB,      // Control signal LB
    output wire RstP     // Reset signal RstP
);

    // Control signal assignments
    assign Psel = b0;
    assign EP = (b0 & ~load);
    assign EA = (~z | load);
    assign EB = (~z | load);
    assign LA = load;
    assign LB = load;
    assign RstP = load;

endmodule
