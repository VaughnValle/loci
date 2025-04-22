### Problem 1: Average CPI

The program’s instructions execute in three categories:

- 80% are register instructions (without stalls) that take **4 clock cycles**,
- 15% are register instructions with stalls that take **10 clock cycles**,
- 5% are memory instructions with stalls that take **30 clock cycles**.

The overall average CPI is computed as a weighted sum:

  **CPI = 0.80×4 + 0.15×10 + 0.05×30  
     = 3.2 + 1.5 + 1.5  
     = 6.2**

So, the overall average CPI is **6.2**.

---
### Problem 2: Identify Conflicts in Code Excerpts

For each excerpt we list:
#### 2(a)

```
1: movi $1, 5  
2: add $2, $1, $1  
3: add $3, $1, $1  
```

- **Data conflicts (RAW):**
    - _Instruction 1 → Instruction 2:_ Instruction 1 writes to **$1** and Instruction 2 reads from **$1**.
    - _Instruction 1 → Instruction 3:_ Instruction 1 writes to **$1** and Instruction 3 reads from **$1**.
- **Control hazards:** None
- **Structural hazards:** None (do not occur on the E20)

---
#### 2(b)

```
1: movi $1, 5  
2: addi $1, $1, 20  
```

- **Data conflict (RAW):**
    - _Instruction 1 → Instruction 2:_ Instruction 1 writes **$1** and Instruction 2 reads and then writes **$1**.
- **Control hazards:** None

---
#### 2(c)

```
1: sw $1, 0($4)  
2: movi $5, 40  
3: sw $2, 0($4)  
```

- **Data conflict (Write‐after‐Write):**
    - _Instruction 1 → Instruction 3:_ Both store to the same memory location (address computed as 0+$4).
- **Control hazards:** None

---
#### 2(d)

```
1: addi $1, $7, 1  
2: add $2, $3, $3  
3: add $4, $3, $5  
4: jal some_label  
```

- **Data conflicts:** None (no instruction uses the output of another).
- **Control hazard:**
    - _Instruction 4 (jal):_ Being a jump instruction, it has an inherent control hazard.
- **Structural hazards:** None

---
#### 2(e)

```
1: movi $1, 50  
2: jr $1  
```

- **Data conflict (RAW):**
    - _Instruction 1 → Instruction 2:_ The jump register instruction reads **$1**, which is written by instruction 1.
- **Control hazard:**
    - _Instruction 2 (jr):_ As a jump instruction, it poses a control hazard.
- **Structural hazards:** None

---
#### 2(f)

```
1: add $1, $2, $2  
2: add $5, $3, $3  
3: add $4, $2, $3  
```

- **Data conflicts:** None.  
    (Although instructions 1 and 3 both use **$2**, and instructions 2 and 3 both use **$3**, these are read operations only.)
- **Control hazards:** None

---
#### 2(g)

```
1: movi $1, 40  
2: sw $1, 0($5)  
3: movi $1, 50  
4: sw $1, 1($5)  
```

- **Data conflicts:**
    - _Instruction 1 → Instruction 2 (RAW):_ Instruction 2 uses **$1** (set by instruction 1).
    - _Instruction 1 → Instruction 3 (WAW):_ Both write to **$1**.
    - _Instruction 3 → Instruction 4 (RAW):_ Instruction 4 uses **$1** produced by instruction 3.
- **Control hazards:** None

---

### Problem 3: Valid Reorderings of Code Excerpts

A valid reordering must preserve the relative order of any instructions that conflict.

---
#### 3(a)

For:

```
1: movi $1, 5  
2: add $2, $1, $1  
3: add $3, $1, $1  
```

- **Conflicts:** Instruction 1 must come before both 2 and 3.
- **Valid reorderings:**
    - **1, 2, 3** (original)
    - **1, 3, 2**

---
#### 3(b)

For:

```
1: movi $1, 5  
2: addi $1, $1, 20  
```

- **Conflict:** Instruction 1 must come before instruction 2.
- **Valid reordering:**
    - **1, 2** only

---
#### 3(c)

For:

```
1: sw $1, 0($4)  
2: movi $5, 40  
3: sw $2, 0($4)  
```

- **Conflict:** Instruction 1 must precede instruction 3 (to preserve the intended final memory store).
- **Valid reorderings:**
    - **1, 2, 3** (original)
    - **1, 3, 2**
    - **2, 1, 3**  
        (Any ordering that keeps instruction 1 before instruction 3 is valid.)

---
#### 3(d)

For:

```
1: addi $1, $7, 1  
2: add $2, $3, $3  
3: add $4, $3, $5  
4: jal some_label  
```

- **Conflicts:** None among instructions 1–3. However, since instruction 4 is a jump (control hazard), it should remain the last instruction (to preserve program flow).
- **Valid reorderings:**
    - All permutations of instructions 1, 2, and 3 placed before instruction 4.  
        That is, the six orderings:  
          • 1, 2, 3, 4  
          • 1, 3, 2, 4  
          • 2, 1, 3, 4  
          • 2, 3, 1, 4  
          • 3, 1, 2, 4  
          • 3, 2, 1, 4

---
#### 3(e)

For:

```
1: movi $1, 50  
2: jr $1  
```

- **Conflict:** Instruction 1 must come before instruction 2.
- **Valid reordering:**
    - **1, 2** only

---
#### 3(f)

For:

```
1: add $1, $2, $2  
2: add $5, $3, $3  
3: add $4, $2, $3  
```

- **Conflicts:** None.
- **Valid reorderings:**
    - All 6 permutations are valid:  
          • 1, 2, 3  
          • 1, 3, 2  
          • 2, 1, 3  
          • 2, 3, 1  
          • 3, 1, 2  
          • 3, 2, 1

---
#### 3(g)

For:

```
1: movi $1, 40  
2: sw $1, 0($5)  
3: movi $1, 50  
4: sw $1, 1($5)  
```

- **Conflicts:**
    - Instruction 1 must come before Instruction 2.
    - Instruction 1 must come before Instruction 3 (to avoid WAW conflict).
    - Instruction 3 must come before Instruction 4.
- **Valid reordering:**
    - The dependencies force the original order: **1, 2, 3, 4** is the only valid ordering.

---
### Problem 4: Hazards and NOP Insertion

Given program:

```
lw   $1, data($0)    #ram[0]
jeq  $1, $0, skip    #ram[1]
addi $3, $0, 0       #ram[2]
addi $2, $1, 5       #ram[3]
sub  $3, $1, $2     #ram[4]
skip:
halt               #ram[5]
data:
.fill 10            #ram[6]
```

#### 4(a) Identify Hazards

Examine each instruction (assume a 5‐stage pipeline without forwarding):

- **Instruction at ram[0] (lw $1, data($0)):**
    
    - **Hazard effect:** Its loaded value in **$1** is used by later instructions.
- **Instruction at ram[1] (jeq $1, $0, skip):**
    
    - **Data hazard (RAW):** It reads **$1** which is produced by the lw at ram[0].
    - **Control hazard:** As a branch instruction, its outcome (whether to jump) is not resolved until later in the pipeline.
- **Instruction at ram[3] (addi $2, $1, 5):**
    
    - **Data hazard (RAW):** It reads **$1** from the lw at ram[0].
- **Instruction at ram[4] (sub $3, $1, $2):**
    
    - **Data hazards (RAW):**
        - Reads **$1** (from the lw at ram[0]).
        - Reads **$2** (produced by the addi at ram[3]).

_Note:_ Although instructions at ram[2] and ram[5] do not introduce hazards themselves, the above hazards dictate stalls in the pipeline.

---
#### 4(b) NOP Insertion to Eliminate Data Hazards

Without reordering, we insert enough **nop** instructions so that the writing instruction completes its WB stage before the consuming instruction reads the register. Typical 5‐stage pipelines (without forwarding) require two nops after a load (or an ALU instruction that produces a value) if the very next instruction uses its result.

A safe reordering using **nop** insertion is:

```
lw   $1, data($0)    #ram[0]
nop                  # Inserted to allow lw $1 to write back
nop                  # Second nop for safety
jeq  $1, $0, skip    #ram[1]
addi $3, $0, 0       #ram[2]
addi $2, $1, 5       #ram[3]
nop                  # Inserted to allow addi $2 to write back
nop                  # Second nop before using $2
sub  $3, $1, $2       #ram[4]
skip:
halt                 #ram[5]
data:
.fill 10             #ram[6]
```

**Explanation:**

- **After the lw at ram[0]:** Two **nop** instructions are inserted before the branch (jeq) to ensure that **$1** is updated.
- **Before the sub at ram[4]:** Two **nop** instructions are inserted after the addi at ram[3] to guarantee that **$2** is available when sub reads it. (The sub also reads **$1**, but that value was loaded earlier and by then is available.)

This rewritten program eliminates the data hazards without reordering the original instructions.