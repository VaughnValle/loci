// Implementation of a full addder

//   Inputs: A, B, Cin bits
//   Outputs: sum bit S, carry out bit Cout
//
module full_adder_nodelay(A, B, Cin, S, Cout);

   input A, B, Cin;
   output S, Cout;

   assign S = A ^ B ^ Cin;
   assign Cout = (A & B) | (A & Cin) | (B & Cin);

endmodule // full_adder_nodelay