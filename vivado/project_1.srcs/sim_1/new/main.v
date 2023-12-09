`timescale 1ns / 1ps

module main(input clk, input btnC, input [7:0]Num1, input [7:0]Num2, output [15:0]Output
//, output mul_finished, output out_sign
); // Switch to control loading of A);

    wire new_clk;

     clockDivider #() new_clock(.clk(clk), .rst(1'b0),.en(1'b1),.clk_out(new_clk ));

   
   wire [7:0] Num1_complement, Num2_complement;
   wire [7:0] A, B, B_shifted;
   wire [15:0] A_shifted;
   reg [15:0] P;
   wire [15:0] P_in; // Product 16-bit register and the wire entering it
   wire out_sign;
   wir mul_finished;

   twos_complementor complementor1(Num1, Num1_complement);
   twos_complementor complementor2(Num2, Num2_complement);

   assign A = (Num1[7]==1) ? Num1_complement : Num1;
   assign B = (Num2[7]==1) ? Num2_complement : Num2;

   
   wire enable1, enable2;
   debouncer deb(.clk(new_clk), .rst(1'b0), .in(btnC), .out(enable1)); 
   synchronizer synch(.clk(new_clk), .rst(1'b0), .in(enable1), .out(enable2)); 
   

   
   wire Psel, EP, EA, EB, LA, LB, RstP;
   CU c(.b0(B[0]), .z(mul_finished), .load(enable2), .Psel(Psel), .EP(EP), .EA(EA), .EB(EB), .LA(LA), .LB(LB), .RstP(RstP));
   
   shift_right_register sh_right(.clk(new_clk), .load(EB), .en(LB), .Num(B),.Out(B_shifted)); // output (B_shifted will be used in CU)
   shift_left_register sh_left(.clk(new_clk), .load(LA), .en(EA),.Num(A), .Out(A_shifted));
   
   assign mul_finished = ~(B_shifted[0] | B_shifted[1] | B_shifted[2] | B_shifted[3] | B_shifted[4] | B_shifted[5] | B_shifted[6] | B_shifted[7]);


   always @(posedge new_clk) begin
      
      if (EP == 1)
        P <= (Psel==1)?P+A:P;
      
      if (RstP == 1)
        P <= 0;
      
    
   end

   assign out_sign = A[7] ^ B[7];

   assign Output = P;

endmodule
