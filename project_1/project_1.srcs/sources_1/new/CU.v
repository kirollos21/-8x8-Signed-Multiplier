`timescale 1ns / 1ps

module CU(input b0, z, load, output Psel, EP, EA, EB, LA, LB, RstP);

assign Psel = b0;
assign EP = (b0 & ~(load));
assign EA = (~(z) | load);
assign EB = (~(z) | load);
assign LA = load;
assign LB = load;
assign RstP = load;

endmodule
