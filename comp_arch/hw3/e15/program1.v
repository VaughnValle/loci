/*          OPCODE SRC  DST  IMMDATA */
myROM[0] = {movi, RXX, Rg1, 4'b0101};
myROM[1] = {mov,  Rg1, Rg2, 4'b0000};
myROM[2] = {mov,  Rg1, Rg3, 4'b0000};
myROM[3] = {addi, RXX, Rg2, 4'b0001};
myROM[4] = {subi, RXX, Rg3, 4'b0001};
myROM[5] = {jmp,  RXX, RXX, 4'b0000};
myROM[6] = {jmp,  RXX, RXX, 4'b0000};
myROM[7] = {jmp,  RXX, RXX, 4'b0000};
myROM[8] = {jmp,  RXX, RXX, 4'b0000};
myROM[9] = {jmp,  RXX, RXX, 4'b0000};
myROM[10] = {jmp,  RXX, RXX, 4'b0000};
myROM[11] = {jmp,  RXX, RXX, 4'b0000};
myROM[12] = {jmp,  RXX, RXX, 4'b0000};
myROM[13] = {jmp,  RXX, RXX, 4'b0000};
myROM[14] = {jmp,  RXX, RXX, 4'b0000};
myROM[15] = {jmp,  RXX, RXX, 4'b0000};

/*
Expected output:

Final state of register file:
    r0= x
    r1= 5
    r2= 6
    r3= 4

*/