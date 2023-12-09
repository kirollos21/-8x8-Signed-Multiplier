`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/06/2023 02:32:49 PM
// Design Name: 
// Module Name: Test_mltiplier
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


module Test_mltiplier();
reg clk,  btnC, EP, EA, EB, LA, LB;
reg  [7:0]Num1, Num2;
wire [15:0]Output;
wire [7:0] A, B;

main m( .clk(clk),  .btnC(btnC), .Num1(Num1), .Num2(Num2),.EP(EP), .EA(EA), .EB(EB), .LA(LA), .LB(LB),.Output(Output));

initial begin

clk=0;
forever #10 clk=~clk;
end

initial begin
    Num1 = 8'b00000101;
    Num2= 8'b00000001;
    btnC =0;
    
    #10
    EA=0;
    EB=0;
    LA=1;
    LB=1;
        
    #30
    btnC =1;
    EA=1;
    EB=1;
        LA=0;
    LB=0;
end
endmodule
