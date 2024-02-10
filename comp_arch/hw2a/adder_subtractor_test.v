// Test bench to compare timing for ripple carry adder and carry
// lookahead adder with simulated propagation delays. 

// Tell Icarus Verilog compiler what our timescale is (to interpret
// delay statements).
`timescale 1ns/100ps
`default_nettype none

// Include the module source file for the adder/subtractor
`include "four_bit_adder_subtractor.v"

// Define our testbench module:
module adder_subtractor_test();


   // Set up two 4-bit registers A & B for our addends.
   reg signed [3:0]  A = 4'b0;
   reg signed [3:0]  B = 4'b0;

   // And one for Cin (we will leave it at zero, however).
   reg        Op = 0;

   // Set up two different 4-bit wires to hold results of sums: one
   // expected result from built-in Verilog arithmetic, and one 
   // and one from your module
   wire [3:0] S_expected;
   wire [3:0] S_actual;

   // We're going to ignore Cout here in our tests, but we need to
   // define it as an output of our adder/subtractor.
   wire       Cout;

   task check;
      input op;
      input signed [3:0] a;
      input signed [3:0] b;
      input signed [3:0] actual;
      input signed [3:0] expected;
      if (expected !== actual) begin 
         $display("When %s %d and %d, got %d, but expected %d", op?"subtracting":"adding", a,b,actual,expected); 
      end
   endtask

   task test;
      input op;
      input signed [3:0] a;
      input signed [3:0] b;
      begin
         #20 A = a; B = b; Op = op;
         #20 check(op, a, b, S_actual, S_expected);
      end
   endtask
   
   // The syntax (x ? y : z) here evaluates to "y if x is true, and z otherwise"
   assign {S_expected} = Op ? A - B : A + B;

   // Instantiate our module for adder/subtractor
   four_bit_adder_subtractor adder(A, B, Op, S_actual, Cout);

   // This is the behavioral verilog segment to actually run our
   // tests. Note we are just setting values of A and B every 20 ticks
   // of the clock, and then finishing.
   initial begin

      $dumpfile("adder_subtractor_test.vcd");
      $dumpvars(0, adder_subtractor_test);

      #20 test(0, 1, 1);
      #20 test(1, 1, 1);
      #20 test(0, 2, 5);
      #20 test(1, 2, 5);
      #20 test(0, 4, -4);
      #20 test(1, 4, -4);
      #20 test(0, 7, 7); 
      #20 test(1, 7, 7); 
      #20 test(1, 7, 4); 
      #20 test(1, 7, 0); 
      #20 test(1, 3, 0); 
      
      #20 $finish;

   end

endmodule
