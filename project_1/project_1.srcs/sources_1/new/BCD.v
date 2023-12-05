`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/04/2023 03:47:32 PM
// Design Name: 
// Module Name: BCD
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


module BCD (
  input      [15:0] binaryInput,  // 16-bit binary input
  output reg [19:0] bcdOutput    // BCD output: {..., thousands, hundreds, tens, ones}
);

  integer i, j;

  always @(binaryInput) begin
  
    // Fill BCD with zeros
    for (i = 0; i < 20; i = i + 1)
      bcdOutput[i] = 0;

    // Copy binary input to initialize BCD
    bcdOutput[15:0] = binaryInput;

    // Iterate through the structure 
    for (i = 0; i <= 12; i = i + 1)
      for (j = 0; j <= i/3; j = j + 1)
        if (bcdOutput[16-i+4*j -: 4] > 4) // If a BCD digit is greater than 4
          bcdOutput[16-i+4*j -: 4] = bcdOutput[16-i+4*j -: 4] + 4'd3; // Add 3
  end

endmodule

