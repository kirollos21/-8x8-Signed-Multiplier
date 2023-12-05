`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/04/2023 03:45:58 PM
// Design Name: 
// Module Name: shift_left_register
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


module shift_left_register(input clk, load, en,[7:0]Num, output reg[15:0]Out );
integer i;
always @(posedge clk) begin 
    if(load)begin
        Out<={8'b0,Num};
    end
    else begin
        if(en)begin 
            for(i=1; i<16;i=i+1)begin
                Out[i]<=Out[i-1];
            end
             Out[0]<=1'b0;
         end
    end
end
endmodule

