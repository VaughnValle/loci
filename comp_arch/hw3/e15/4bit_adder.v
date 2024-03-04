`include "full_adder_nodelay.v"

module fourbit_adder(A,B, Cin, S, Cout);

    input [3:0] A;
    input [3:0] B;
    input Cin;
    output[3:0] S;
    output Cout;

    wire temp0, temp1, temp2;

    full_adder_nodelay first(A[0], B[0], Cin, S[0], temp0);
    full_adder_nodelay second(A[1], B[1], temp0, S[1], temp1);
    full_adder_nodelay third(A[2], B[2], temp1, S[2], temp2);
    full_adder_nodelay fourth(A[3], B[3], temp2, S[3], Cout);

endmodule
