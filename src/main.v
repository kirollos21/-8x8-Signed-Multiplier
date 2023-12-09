// File: main.v
// Description: Main module implementing various functionalities including clock division,
// two's complement calculation, debouncing, synchronization, shifting, control unit logic,
// and seven-segment display control.

// Copyright 2023 by Ahmed Allam, Kirollos Ehab, Eslam Tawfik, and Hussien ElAzhary
// License: MIT

// Coding practices based on guidelines available at:
// https://github.com/shalan/verilog_coding_guidelines

`timescale 1ns / 1ps
`default_nettype none

module main(
    input wire clk,
    input wire btnC,  // Center button
    input wire btnL,  // Left button
    input wire btnR,  // Right button
    input wire [7:0] num1,  // 8-bit input number 1
    input wire [7:0] num2,  // 8-bit input number 2
    output wire [6:0] seg,           // 7-segment display segments
    output wire [3:0] an,             // 7-segment display anodes
    output wire multiplicationFinished   // Led for multiplication status
);

    wire dividedClock;  // Divided clock signal

    // Instance of clockDivider
    clockDivider #() clockDiv(
        .clk(clk),
        .rst(1'b0),
        .en(1'b1),
        .clk_out(dividedClock)
    );

    wire [7:0] num1Complement, num2Complement;
    wire [7:0] multiplier, multiplicand;
    wire [7:0] multiplicandShifted;
    wire [15:0] multiplierShifted;
    reg  [15:0] productReg;
    reg signReg;
    wire tempSign;
    wire [19:0] bcdOutput;
    wire [15:0] tempOutput;

    // Two's complement calculation for num1 and num2
    assign num1Complement = ~num1 + 1'b1;
    assign num2Complement = ~num2 + 1'b1;

    assign multiplier = (num1[7] == 1) ? num1Complement : num1;
    assign multiplicand = (num2[7] == 1) ? num2Complement : num2;

    wire enableDebounce, enableSync;
    debouncer debounceInst(
        .clk(dividedClock),
        .rst(1'b0),
        .in(btnC),
        .out(enableDebounce)
    );
    synchronizer syncInst(
        .clk(dividedClock),
        .rst(1'b0),
        .in(enableDebounce),
        .out(enableSync)
    );

    wire Psel, EP, EA, EB, LA, LB, RstP;

    shift_right_register shiftRightReg(
        .clk(dividedClock),
        .load(LB),
        .en(EB),
        .Num(multiplicand),
        .Out(multiplicandShifted)
    );
    shift_left_register shiftLeftReg(
        .clk(dividedClock),
        .load(LA),
        .en(EA),
        .Num(multiplier),
        .Out(multiplierShifted)
    );

    CU controlUnit(
        .b0(multiplicandShifted[0]),
        .z(multiplicationFinished), // zero flag
        .load(enableSync),
        .Psel(Psel),
        .EP(EP),
        .EA(EA),
        .EB(EB),
        .LA(LA),
        .LB(LB),
        .RstP(RstP)
    );

    assign multiplicationFinished = ~(multiplicandShifted[0] | multiplicandShifted[1] | multiplicandShifted[2] | multiplicandShifted[3] | multiplicandShifted[4] | multiplicandShifted[5] | multiplicandShifted[6] | multiplicandShifted[7]);

    always @(posedge dividedClock) begin
        if (RstP == 1) begin
            // Reset the product register
            productReg <= 16'b0;
            signReg <= (num1[7] ^ num2[7]) && num1 != 0 && num2 != 0;
        end else if (EP == 1) begin
            // Update product register based on Psel value
            productReg <= (Psel == 1) ? productReg + multiplierShifted : productReg;
        end else begin
            // Maintain the current state of productReg if none of the above conditions are met
            productReg <= productReg;
        end
    end

    assign tempOutput = productReg;
    assign tempSign = signReg;

    BCD #(16) bcdConverter(
        .bin(tempOutput),
        .bcd(bcdOutput)
    );

    seven_segment_scroller sevenSegScroller(
        .clk(clk),
        .reset(RstP),
        .button_left(btnL),
        .button_right(btnR),
        .product(bcdOutput),
        .sign(tempSign),
        .seg(seg),
        .an(an)
    );

endmodule
