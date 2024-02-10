module binary_to_gray (
    input [3:0] B,
    output [3:0] G
);

// Assign MSB directly
assign G[3] = B[3];

// Connect remaining bits with XOR operations
assign G[2] = B[2] ^ B[3];
assign G[1] = B[1] ^ B[2];
assign G[0] = B[0] ^ B[1];

endmodule

