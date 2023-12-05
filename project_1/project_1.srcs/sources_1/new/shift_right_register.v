`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/04/2023 03:41:59 PM
// Design Name: 
// Module Name: shift_right_register
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module shift_right_register( input clk, load, en,[7:0]Num, output reg[7:0]Out );
integer i;
always @(posedge clk) begin 
    if(load)begin
        Out<=Num;
    end
    else begin
        if(en)begin 
            for(i=7; i>=0;i=i-1)begin
                Out[i-1]<=Out[i];
            end
             Out[7]<=1'b0;
         end
    end
end
endmodule
