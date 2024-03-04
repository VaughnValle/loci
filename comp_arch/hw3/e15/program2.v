/*          OPCODE SRC  DST  IMMDATA */
myROM[0] = {movi, RXX, Rg2, 4'b0000};
myROM[1] = {movi, RXX, Rg1, 4'b0111};
myROM[2] = {subi, RXX, Rg1, 4'b0010};
myROM[3] = {addi, RXX, Rg2, 4'b0011};
myROM[4] = {cmpi,  RXX, Rg1, 4'b0001};
myROM[5] = {jz,  RXX, RXX, 4'b0010};
myROM[6] = {jmp, RXX, Rg2, 4'b1100};  
myROM[7] = {jmp, RXX, RXX, 4'b0000};
myROM[8] = {jmp, RXX, RXX, 4'b0000};
myROM[9] = {jmp, RXX, RXX, 4'b0000};
myROM[10] = {jmp, RXX, RXX, 4'b0000};
myROM[11] = {jmp, RXX, RXX, 4'b0000};
myROM[12] = {jmp, RXX, RXX, 4'b0000};
myROM[13] = {jmp, RXX, RXX, 4'b0000};
myROM[14] = {jmp, RXX, RXX, 4'b0000};
myROM[15] = {jmp, RXX, RXX, 4'b0000};

/*
Expected output:

Final state of register file:
    r0= x
    r1= 1
    r2= 9
    r3= x

*/