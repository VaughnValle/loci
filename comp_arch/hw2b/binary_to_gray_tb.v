// Verilog test bench for E15 homework 5 problem 3.

`timescale 1ns/100ps
`default_nettype none
`include "binary_to_gray.v"

module binary_to_gray_tb;

   wire [3:0] B;
   wire [3:0] G;
   integer k=0;

   assign B = k;
   binary_to_gray the_circuit(B, G);

   initial begin

      $dumpfile("binary_to_gray.vcd");
      $dumpvars(0, binary_to_gray_tb);

      for (k=0; k<16; k=k+1)
        #10 $display("done testing case %d", k);

      $finish;

   end 
endmodule
