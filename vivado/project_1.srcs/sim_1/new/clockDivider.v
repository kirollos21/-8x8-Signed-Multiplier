`timescale 1ns / 1ps

module clockDivider #(parameter n = 100_000_000/2)(input clk, en, rst, output reg clk_out);
wire [31:0] count;

counterModN #(.x(32),.n(n)) counterMod (.clk(clk), .reset(rst), .en(en), .count(count));


always @ (posedge clk, posedge rst) begin
if (rst)
clk_out <= 0;
else if (count == n-1)
clk_out <= ~ clk_out;
end
endmodule