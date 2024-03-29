module E15Process(input clk);

   // Execution stages
   parameter 
      fetch=2'd0, 
      decode=2'd1, 
      exec=2'd2, 
      store=2'd3;

   // Register names
   parameter 
      Rg0 = 2'b00, Rg1 = 2'b01,
      Rg2 = 2'b10, Rg3 = 2'b11, 
      RXX = 2'b00;

   // Opcodes
   parameter
     jmp  = 4'b0000, jz   = 4'b0010,
     movi = 4'b1001, mov  = 4'b1000,
     addi = 4'b1011, add  = 4'b1010,
     subi = 4'b1101, sub  = 4'b1100,
     cmpi = 4'b1111, cmp  = 4'b1110,
     jnz  = 4'b0011;
   
   // Bus signals
   parameter   
     bEn_R0 = 3'd0, bEn_R1 = 3'd1, 
     bEn_R2 = 3'd2, bEn_R3 = 3'd3, 
     bEn_ALU = 3'd4, bEn_Imm = 3'd5;

   reg [3:0] pc;              // Program Counter
   reg [3:0] r0, r1, r2, r3;  // Registers

   wire [3:0] mBus, dstBus;    // Buses
   reg [3:0] opCode;          // op code
   reg [1:0] src, dst;        // src and dst register
   reg [3:0] immData;         // "Immediate" data


   reg  [3:0] pcIncr; // Program Counter Increment
   wire [3:0] pcRes;  // Output of pc ALU
   wire       pcz;    // Unused - zero flag for pc ALU
   
   reg [1:0]  myState;      // State (phase of excution)
   reg [11:0] myROM [15:0]; // ROM (holds program)
   reg [3:0]  mbEn, dbEn;   // Used to determine which values are passed
                            // on the two buses

   reg        addNotSub; // Determines if ALU adds or subtracts
   reg [3:0]  aluOut;    // Register to hold output of main ALU
   reg        zFlag;     // Zero flag
   wire [3:0] resVal;    // Output (combinational) of ALU
   wire       zVal;      // Output (combinational) of ALU zero flag

   initial
     begin

        `include "program1.v"
        
        pc = 4'b0000;
        myState = fetch;
        
     end
   
   always @(posedge clk)
     case(myState)
       // Fetch phase:
       //    Save instruction to registers.
       //    Move to next phase.
       fetch:
         begin
            {opCode, src, dst, immData} = myROM[pc];
            myState <= decode;
         end

       // Decode phase:
       //    Send concrete values to ALU by setting
       //    mbEn and dbEn to to read the appropriate
       //    values (registers or immediates).
       //    Set addNotSub appropriately for arithmetic.
       //    Move to next phase.
       decode:
         begin
            // TODO: set mbEn, dbEn, addNotSub, and myState
            //       based on opCode
         end
       
       // Exec phase:
       //    Read result from ALU, for instructions that
       //    use it:
       //       Set mbEn to select results from ALU.
       //       Set aluOut to ALU numeric output.
       //       Set zFlag to ALU zero flag output.
       //    Set pcIncr to the relative address of
       //    the next instruction, depending on the
       //    opcode.
       //    Move to next phase.
       exec:
         begin
            case(opCode)
              addi, add, subi, sub, cmpi, cmp:
                begin
                   mbEn <= bEn_ALU;
                   aluOut <= resVal;
                   zFlag <= zVal;
                end
            endcase
            // TODO: set pcIncr
            myState <= store;
         end
       
       // Store phase:
       //    Write registers, if appropriate.
       //    Increment pc and move to first phase.
       store:
         begin
            // TODO: store value from mBus into register, if appropriate
            pc <= pcRes;
            myState <= fetch;
         end
       
     endcase
   
   assign mBus = (mbEn==bEn_R0)  ? r0      : 
                 (mbEn==bEn_R1)  ? r1      : 
                 (mbEn==bEn_R2)  ? r2      : 
                 (mbEn==bEn_R3)  ? r3      : 
                 (mbEn==bEn_Imm) ? immData : 
                 (mbEn==bEn_ALU) ? aluOut  : 0 ;

   assign dstBus = (dbEn==bEn_R0)  ? r0 :
                   (dbEn==bEn_R1)  ? r1 :
                   (dbEn==bEn_R2)  ? r2 :
                   (dbEn==bEn_R3)  ? r3 : 0;

   simpleALU dataALU(addNotSub, mBus, dstBus, zVal, resVal);
   simpleALU pcALU(1'b1, pc, pcIncr, pcz, pcRes);

endmodule


module simpleALU(
    input addNotSub,
    input [3:0] src, dst,
    output zFlag,
    output [3:0] res);
    assign res = addNotSub ? dst + src : dst - src;
    assign zFlag = !(res);
endmodule


//ra0Eequ6ucie6Jei0koh6phishohm9