`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/06/2023 03:01:32 PM
// Design Name: 
// Module Name: Test
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


module Test();
reg [15:0]i;
wire [19:0]out;
 BCD b( .binaryInput(i ), .bcdOutput(out ));
  

initial begin
i=16'b1010101011111111;
#20
i=22;
#20
i=15;
#10
i=122;

end

  
endmodule
