`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/05/2023 03:12:15 PM
// Design Name: 
// Module Name: main
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


module main(input clk,[7:0]Num1, [7:0]Num2, output [15:0]Output);
wire [7:0]Num1_complement,Num2_complement;
reg [7:0]A,B,A_shifted,B_shifted;
reg [15:0]P; wire [15:0]P_in; // Product 16-bit register and the wire entering it
wire Load_A,Load_B,en_A,en_B;
 
twos_complementor complementor1(Num1,Num1_complement );
twos_complementor complementor2(Num2,Num2_complement );

assign A= (Num1[7]==1)?Num1_complement:Num1;
assign B= (Num2[7]==1)?Num2_complement:Num2;

shift_right_register sh_right(.clk(clk), .load(Load_B), .en(en_B), .Num(B),.Out(B_shifted)); // output (B_shifted will be used in CU)
shift_left_register sh_left(.clk(clk), .load(Load_A), .en(en_B),.Num(A), .Out(A_shifted ) );
CU c();//It should output all enables and all Loads

//always @()  // @ any enable or load
always @(posedge clk) begin 
end
endmodule
