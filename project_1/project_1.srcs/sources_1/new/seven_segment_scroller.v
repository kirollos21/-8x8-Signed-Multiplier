`timescale 1ns / 1ps

module seven_segment_scroller(input clk, input reset, input BTNL, input BTNR, input [19:0] product, output reg [6:0] seg, output reg [3:0] an);

    wire slow_clk;
    wire [1:0] sw;
    wire debounced_BTNL, debounced_BTNR, final_BTNL, final_BTNR;
    wire [3:0] bcd_digit;
    reg [2:0] digit_select = 0;
    reg [6:0] seg_internal[4:0];
    reg previous_BTNL = 0, previous_BTNR = 0;
    
    clockDivider #(250000)clk_div1(.clk(clk), .en(1'b1), .rst(reset), .clk_out(slow_clk));
    
    counterModN #(.x(2), .n(3)) TEMP (.clk(slow_clk), .reset(reset), .en(1'b1), .count(sw));

    debouncer db_btnl(.clk(slow_clk), .rst(reset), .in(BTNL), .out(debounced_BTNL));
    synchronizer syn_btnl(.clk(slow_clk), .rst(reset), .in(debounced_BTNL), .out(final_BTNL));
    
    debouncer db_btnr(.clk(slow_clk), .rst(reset), .in(BTNR), .out(debounced_BTNR));
    synchronizer syn_btnr(.clk(slow_clk), .rst(reset), .in(debounced_BTNR), .out(final_BTNR));
    
    always @(posedge final_BTNL or posedge final_BTNR or posedge reset) begin
            if (reset) begin
                digit_select <= 0;
//                previous_BTNL <= 0;
//                previous_BTNR <= 0;
            end else begin
//                previous_BTNL <= final_BTNL;
//                previous_BTNR <= final_BTNR;
    
                if (final_BTNR && digit_select > 0) begin
                    digit_select <= digit_select - 1;
                end else if (final_BTNL && digit_select < 2) begin
                    digit_select <= digit_select + 1;
                end
            end
        end
    
    initial begin
        seg_internal[0] = 7'b1111001;
        seg_internal[1] = 7'b0100100;
        seg_internal[2] = 7'b0110000;
        seg_internal[3] = 7'b0011001;
        seg_internal[4] = 7'b0010010;
    end
    
    
    always @(sw) begin
    case (sw)
        0: begin
            an = 4'b1110;
            if (digit_select == 0)
                seg = seg_internal[0];
            else if (digit_select == 1)
                seg = seg_internal[1];
            else if (digit_select == 2)
                seg = seg_internal[2];
        end
        1: begin
            an = 4'b1101;
            if (digit_select == 0)
                seg = seg_internal[1];
            else if (digit_select == 1)
                seg = seg_internal[2];
            else if (digit_select == 2)
                seg = seg_internal[3];
        end
        2: begin
            an = 4'b1011;
            if (digit_select == 0)
                seg = seg_internal[2];
            else if (digit_select == 1)
                seg = seg_internal[3];
            else if (digit_select == 2)
                seg = seg_internal[4];
        end
    endcase
    end
    
    
endmodule