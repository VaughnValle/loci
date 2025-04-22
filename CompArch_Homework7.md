## Homework 7
**by Vaughn Valle**

_made in Obsidian.md_

If you have a Markdown reader, I strongly suggest you use it to view this for vastly increased readibility. Enjoy! :)

1.
```verilog
# Vaughn Vlale
# Efficient Multiplication in E20

# Register Usage:
# $1: Stores the final product (result). Initially 0.
# $2: Stores the multiplicand (m), read from memory.
# $3: Stores the multiplier (n), read from memory.
# $4: Stores the current bitmask (starts at 1, shifts left).
# $5: Temporary register for checking multiplier bit (n & bitmask).
# $6: Temporary register holding the potentially shifted multiplicand.

main:
    movi $1, 0              # Initialize product register $1 to 0
    lw $2, multiplicand($0) # Load multiplicand (m) into $2
    lw $3, multiplier($0)   # Load multiplier (n) into $3 
    movi $4, 1              # Initialize bitmask in $4 to 1 (checks least significant bit first) 
    add $6, $0, $2          # Initialize shifted multiplicand ($6) with original multiplicand ($2)

multiply_loop:
    # Check if the current bitmask has gone beyond the assumed 7-bit width (e.g., check if bitmask is 128 or greater)
    # We can check if the multiplier becomes 0 after right shifts as an alternative,
    # or limit loop iterations. Here we use a simpler check based on the problem constraint (7-bit inputs)
    # Check if bitmask ($4) is zero, or if we have iterated enough bits.
    # A simple approach for 7 bits is to loop 7 times, or check if multiplier becomes 0.
    # Let's check if the multiplier ($3) has any bits left when considering the mask.
    # A simpler termination: just loop 7 times since input is <= 7 bits. Let's use a counter.
    # Alternative: Check if bitmask ($4) is still relevant (e.g., less than 128 for 7 bits) or if multiplier ($3) is 0.
    # Let's use the bitmask approach: check if bitmask has shifted off relevant bits.
    slti $5, $4, 128        # Check if bitmask ($4) is less than 128 (2^7). If not ($5=0), we're done.
    jeq $5, $0, end_multiply # If bitmask is 128 or greater, exit loop

    # Check if the current bit of the multiplier is set
    and $5, $3, $4          # AND multiplier ($3) with bitmask ($4) 
    jeq $5, $0, skip_add    # If the result is zero, the bit is not set, so skip adding 

    # If the bit is set, add the (shifted) multiplicand to the product
    add $1, $1, $6          # Add shifted multiplicand ($6) to product ($1)

skip_add:
    # Left shift the bitmask for the next iteration
    add $4, $4, $4          # Left shift bitmask ($4 = $4 * 2) 

    # Left shift the multiplicand for the next iteration's potential addition
    add $6, $6, $6          # Left shift multiplicand ($6 = $6 * 2)

    j multiply_loop         # Jump back to the start of the loop

end_multiply:
                        #  the processor, result is in $1

# Data definitions
multiplicand: .fill 123     # The first number to multiply (m) 
multiplier:   .fill 119     # The second number to multiply (n) 

```

Was having a hard time thinking about the loop termination implementation, was complex. Simplified to checking if the bitmask exceeds the relevant bit positions (checking if `$4 < 128`) based on the 7-bit input constraint. Also ensured the shifted multiplicand (`$6`) is updated correctly in each iteration.

**2. Final Value of Register $3**
- The instruction `lw $1, first($0)` loads the value from the memory address `first`. The `.fill 8618` directive is at address 3. Therefore, $1 is loaded with 8618.
- The instruction `lw $2, second($0)` loads the value from the memory address `second`. The `.fill 16388` directive is at address 4. Therefore, $2 is loaded with 16388.
- The instruction `add $3, $1, $2` calculates the sum of the values in $1 and $2 and stores it in $3.

$\$3=8618+16388=25006$
The final value of register $3 is 25006.

**3. Program Execution Analysis**
Looking at the program, it initializes $1 and $4 to 0, loads $3 with 16 from `data`, and then enters a loop. The loop continues as long as the value in $3 is less than 18 (`slti $1, $3, 18` sets $1 to 1; `jeq $1, $0, Skip` does not branch). Inside the loop, $4 is updated (`add $4, $4, $3`), and $3 is incremented (`addi $3, $3, 1`).
- Iteration 1: 3=16. `slti` sets 1=1. `jeq $1, $0` (1==0?) is False (NT). `add $4, $4, 16`. `addi $3, $3, 1` -> 3=17. `jeq $0, $0` (0==0?) is True (T), jumps to Loop. Instructions: `slti, jeq, add, addi, jeq` (5).
- Iteration 2: 3=17. `slti` sets 1=1. `jeq $1, $0` (1==0?) is False (NT). `add $4, $4, 17$.`addi $3, $3, 1`-> $3=18$.`jeq $0, $0`(0==0?) is True (T), jumps to Loop. Instructions:`slti, jeq, add, addi, jeq` (5).
- Iteration 3: $3=18$. `slti` sets $1=0$. `jeq $1, $0` (0==0?) is True (T), jumps to Skip. Instructions: `slti, jeq` (2).
- .

(a)
* Initial instructions: `add $1, $0, $0, add $4, $0, $0, lw $3, data($0)`  3 instructions.
* Loop instructions (run twice for $3=16, 17$): 5 instructions/loop * 2 loops = 10 instructions.
* Final loop check ($3=18$): `slti, jeq` 2 instructions.
* Total instructions executed (excluding ): 3 + 10 + 2 = 15 instructions.

(b) Execution Time (Clock Cycles):
* Given an average CPI of 4.
* Total Cycles = Total Instructions * CPI = 15 * 4 = 60 clock cycles.
(c) Execution Time (Microseconds):
* Given a clock frequency of 1 MHz (1,000,000 cycles/second).
* Execution Time = Total Cycles / Clock Frequency = 60 cycles / 1,000,000 cycles/second = 0.000060 seconds = 60 microseconds (µs).

**4. Pipeline Analysis**

Analyzing the program execution on a 5-stage pipeline (IF, ID, EX, MEM, WB) assuming no forwarding and resolving hazards with stalls.
(a) Read-After-Write (RAW) Data Conflicts:
* Instruction a (`movi $1, 0`) writes to `$1`. Instruction c (`add $1, $1, $2`) reads `$1`. Conflict: a -> c on $1.
* Instruction b (`lw $2, grade1($0)`) writes to `$2`. Instruction c (`add $1, $1, $2`) reads `$2`. Conflict: b -> c on $2.
* Instruction d (`lw $3, grade2($0)`) writes to $3. Instruction e (`add $1, $0, $3`) reads `$3`. Conflict: d -> e on $3.

(b) Pipeline Execution Table (Original Order: a, b, c, d, e):
Note that '-' indicates a stall (bubble).
| Time | IF | ID | EX | MEM | WB 
| 1 | a | | | | |
| 2 | b | a | | | |
| 3 | c | b | a | | |
| 4 | d | c | b | a | |
| 5 | d | - | c | b | a |
| 6 | d | - | - | c | b |
| 7 | e | d | c | - | - |
| 8 | | e | d | c | - |
| 9 | | - | e | d | c |
| 10 | | - | - | e | d |
| 11 | | | e | - | - | 
| 12 | | | | e | - |
| 13 | | | | | e |
| 14 | | | | |  |

(c) Re-ordered Instructions:

To minimize stalls, separate dependent instructions. Conflicts are (a->c), (b->c), (d->e). c depends on a and b. e depends on d. a, b, d are independent loads/moves. We can move d earlier. The final value in $1 comes from e, so e must still execute after c.

Optimal order: a, b, d, c, e

(d) **Pipeline Execution Table (Re-ordered: a, b, d, c, e):**

| Time | IF | ID | EX | MEM | WB

| 1 | a | | | | |
| 2 | b | a | | |
| 3 | d | b | a | | |
| 4 | c | d | b | a | |
| 5 | e | c | d | b | a | 
| 6 | e | - | c | d | b | 
| 7 | e | - | - | c | d | 
| 8 | | e | c | - | - | 
| 9 | | | e | c | - |
| 10 | | | | e | c |
| 11 | | | | | e |
| 12 | | | | |  |

**5. Maximum Clock Frequency**
The maximum clock frequency of a pipelined processor is limited by the time required for the slowest stage. Frequency = 1 / (Slowest Stage Time).
(a) XQ1 Processor:
* Stage times: IF=180ps, ID=150ps, EX=400ps, MEM=230ps, WB=100ps.
* Slowest stage: EX = 400 ps.
* Max Frequency = 1 / (400 * 10⁻¹² s) = 2.5 * 10⁹ Hz = 2.5 GHz.
(b) XQ2 Processor:
* Stage times: IF=180ps, ID=150ps, EX1=250ps, EX2=150ps, MEM=230ps, WB=100ps.
* Slowest stage: EX1 = 250 ps.
* Max Frequency = 1 / (250 * 10⁻¹² s) = 4.0 * 10⁹ Hz = 4.0 GHz.
**6. Branch Prediction Penalties**
Analyzing the provided E20 program which finds the maximum value in the array `[53, 22, 94, 2, 19, 0]`. The conditional branches are `jeq $2, $0, done` (Addr 3) and `jeq $5, $0, next` (Addr 5). Each misprediction costs 3 clock cycles.
- **Branch Trace:**
    - `jeq $2, $0, done` (Addr 3): Executed 6 times. Outcomes: NT, NT, NT, NT, NT, T.
    - `jeq $5, $0, next` (Addr 5): Executed 5 times. Outcomes: NT, T, NT, T, T.

(a) Predict Branch Taken: Penalty occurs when branch is Not Taken (NT).
* Addr 3 (NT, NT, NT, NT, NT): 5 mispredictions * 3 cycles/misprediction = 15 cycles.
* Addr 5 (NT, NT): 2 mispredictions * 3 cycles/misprediction = 6 cycles.
* Total Penalty = 15 + 6 = 21 cycles.
(b) Predict Branch Not Taken: Penalty occurs when branch is Taken (T).
* Addr 3 (T): 1 misprediction * 3 cycles/misprediction = 3 cycles.
* Addr 5 (T, T, T): 3 mispredictions * 3 cycles/misprediction = 9 cycles.
* Total Penalty = 3 + 9 = 12 cycles.
(c) Dynamic Prediction: Predict based on last outcome; predict NT initially. Penalty on misprediction.
* jeq $2, $0, done (Addr 3):
* Exec 1: Outcome NT, Predict NT -> Correct (0 cycles). History=NT.
* Exec 2: Outcome NT, Predict NT -> Correct (0 cycles). History=NT.
* Exec 3: Outcome NT, Predict NT -> Correct (0 cycles). History=NT.
* Exec 4: Outcome NT, Predict NT -> Correct (0 cycles). History=NT.
* Exec 5: Outcome NT, Predict NT -> Correct (0 cycles). History=NT.
* Exec 6: Outcome T, Predict NT -> Mispredict (3 cycles). History=T.
* Penalty (Addr 3) = 3 cycles.
* jeq $5, $0, next (Addr 5):
* Exec 1: Outcome NT, Predict NT -> Correct (0 cycles). History=NT.
* Exec 2: Outcome T, Predict NT -> Mispredict (3 cycles). History=T.
* Exec 3: Outcome NT, Predict T -> Mispredict (3 cycles). History=NT.
* Exec 4: Outcome T, Predict NT -> Mispredict (3 cycles). History=T.
* Exec 5: Outcome T, Predict T -> Correct (0 cycles). History=T.
* Penalty (Addr 5) = 3 + 3 + 3 = 9 cycles.
* Total Penalty = 3 + 9 = 12 cycles.