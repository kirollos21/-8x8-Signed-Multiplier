// File: seven_segment_scroller.v
// This module implements a seven-segment display scroller.
// It scrolls the displayed number based on button inputs and displays a part of a larger number.

// Copyright 2023 by Ahmed Allam, Kirollos Ehab, Eslam Tawfik, and Hussien ElAzhary
// License: MIT

// Coding practices based on guidelines available at:
// https://github.com/shalan/verilog_coding_guidelines

`timescale 1ns / 1ps
`default_nettype none

module seven_segment_scroller(
    input wire clk,                  // Clock input
    input wire reset,                // Asynchronous reset
    input wire button_left,          // Left button input
    input wire button_right,         // Right button input
    input wire [19:0] product,       // 20-bit product input for display
    input wire sign,                 // Sign bit
    output reg [6:0] seg,            // 7-segment display output
    output reg [3:0] an              // 4-bit anode control for the display
);

    // Internal signals
    wire slow_clock;                          // Slowed down clock
    wire [1:0] switch_position;               // Position switch
    wire debounced_button_left, debounced_button_right;
    wire final_button_left, final_button_right;
    wire [6:0] segment_internal[4:0];         // Internal 7-segment display signals
    reg [2:0] digit_selection;       // Digit selection for display

    // Clock divider instantiation
    clockDivider #(250000) clk_divider (
        .clk(clk),
        .en(1'b1),
        .rst(reset),
        .clk_out(slow_clock)
    );

    // Counter instantiation
    counterModN #(.X(2), .N(4)) position_counter (
        .clk(slow_clock),
        .reset(reset),
        .en(1'b1),
        .count(switch_position)
    );

    // Debouncing and synchronizing left button
    debouncer btn_debouncer_left (
        .clk(slow_clock),
        .rst(reset),
        .in(button_left),
        .out(debounced_button_left)
    );
    synchronizer btn_synchronizer_left (
        .clk(slow_clock),
        .rst(reset),
        .in(debounced_button_left),
        .out(final_button_left)
    );

    // Debouncing and synchronizing right button
    debouncer btn_debouncer_right (
        .clk(slow_clock),
        .rst(reset),
        .in(button_right),
        .out(debounced_button_right)
    );
    synchronizer btn_synchronizer_right (
        .clk(slow_clock),
        .rst(reset),
        .in(debounced_button_right),
        .out(final_button_right)
    );

    // Digit selection logic
    reg button_right_old, button_left_old;
    reg button_right_raise, button_left_raise; // to detect rising edge
        
    always @(posedge slow_clock or posedge reset) begin
        if (reset) begin
            digit_selection <= 3'b000;
            button_right_old <= 0;
            button_left_old <= 0;
            button_right_raise <= 0;
            button_left_raise <= 0;
        end else begin
            button_right_raise <= (button_right_old != final_button_right && final_button_right == 1'b1);
            button_left_raise <= (button_left_old != final_button_left && final_button_left == 1'b1);
            
            button_right_old <= final_button_right;
            button_left_old <= final_button_left;
    
            if (button_right_raise) begin
                if (digit_selection > 0) begin
                    digit_selection <= digit_selection - 1;
                end
                button_right_raise <= 0;
            end
    
            if (button_left_raise) begin
                if (digit_selection < 2) begin
                    digit_selection <= digit_selection + 1;
                end
                button_left_raise <= 0;
            end
        end
    end


    // Seven segment decoder instantiations for each digit
    seven_seg_decoder decoder_digit_0 (.en(1'b1), .num(product[3:0]), .seg(segment_internal[0]));
    seven_seg_decoder decoder_digit_1 (.en(1'b1), .num(product[7:4]), .seg(segment_internal[1]));
    seven_seg_decoder decoder_digit_2 (.en(1'b1), .num(product[11:8]), .seg(segment_internal[2]));
    seven_seg_decoder decoder_digit_3 (.en(1'b1), .num(product[15:12]), .seg(segment_internal[3]));
    seven_seg_decoder decoder_digit_4 (.en(1'b1), .num(product[19:16]), .seg(segment_internal[4]));

    // Display control logic
    always @(switch_position) begin
        case (switch_position)
            2'b00: begin
                an <= 4'b1110;
                seg <= segment_internal[digit_selection];
            end
            2'b01: begin
                an <= 4'b1101;
                seg <= segment_internal[digit_selection + 1];
            end
            2'b10: begin
                an <= 4'b1011;
                seg <= segment_internal[digit_selection + 2];
            end
            2'b11: begin
                an <= 4'b0111;
                
                if (sign == 1)
                    seg <= 7'b0111111; 
                else
                    seg <= 7'b1111111;
            end
            default: begin
                // Default case 
                an <= 4'b1111;
                seg <= 7'b0000000;
            end
        endcase
    end

      
endmodule
