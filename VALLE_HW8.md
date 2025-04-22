---
tags:
  - comp-arch
---
Okay, here are the answers to the questions in the Homework 8 PDF, based on the provided documents.

### Question 1: Linked List Summation in E20 Assembly

Code snippet

```
# Initialize sum to 0 in register $1
movi $1, 0      # R[1] <- 0 (Sum = 0) [cite: 259]

# Initialize pointer to the head of the list in register $2
# head is the only data label we can use directly [cite: 11]
# lw reads memory: R[dst] <- Mem[R[addr] + imm] [cite: 239]
# We want the address *stored at* head+1 (the pointer), not the value at head
movi $2, head   # R[2] <- address of 'head'
addi $2, $2, 1  # R[2] <- address of 'head + 1'
lw $2, 0($2)    # R[2] <- Mem[R[2]+0], now R[2] holds the address of the first node (chain1)

loop:
# Check if the current pointer is null (0), indicating the end of the list [cite: 6]
# jeq jumps if R[A] == R[B] [cite: 242]
jeq $2, $0, done # If R[2] (current node address) is 0, jump to done

# Load the value from the current node into register $3
# The value is at the node's address (n) [cite: 5]
lw $3, 0($2)    # R[3] <- Mem[R[2]+0] (Node's value)

# Add the node's value to the sum in register $1
# add: R[dst] <- R[srcA] + R[srcB] [cite: 224]
add $1, $1, $3  # R[1] <- R[1] + R[3] (Sum += Node's value)

# Load the pointer to the next node into register $2
# The pointer is at address n+1 [cite: 6]
addi $2, $2, 1  # R[2] <- address of current node + 1 (address of next pointer)
lw $2, 0($2)    # R[2] <- Mem[R[2]+0] (Address of next node)

# Jump back to the start of the loop
# j jumps unconditionally [cite: 250]
j loop

done:
# The sum is already in register $1 as required [cite: 13]
# Halt the program
halt            # Infinite loop to end program [cite: 263]

# Provided Data Structure [cite: 16]
chain4:
.fill 100       # Assembler directive to insert value into memory [cite: 265]
.fill chain5    # Inserts the address of label chain5
.fill 300
chain7:
.fill 16384
.fill 909
.fill 0
chain1:
.fill 23
.fill chain2
head:           # Label marking the beginning of the list [cite: 117, 128]
.fill 34        # Value of the first pseudo-node (not technically part of the struct list)
.fill chain1    # Pointer stored at head+1, points to chain1
.fill 82
.fill 10
chain3:
.fill 4
.fill chain4
.fill 229
.fill 449
chain2:
.fill 0         # This value (0) is part of the list
.fill chain3    # Pointer to chain3
chain5:
.fill 12
.fill 0         # Null pointer, marks the end of the list for chain4's path
.fill 9999      # Garbage value
chain6:
.fill 99        # Garbage value
.fill 49        # Garbage value
```

Explanation:

The code initializes the sum in register $1 to zero. It then loads the starting address of the linked list (the address stored at the head+1 location) into register $2. The loop (loop:) first checks if the current node address in $2 is zero. If it is, the list has ended, and the program jumps to done:. Otherwise, it loads the node's value (stored at the address in $2) into register $3 and adds this value to the running sum in $1. It then updates $2 to point to the next node by loading the address stored at the current node's address plus one. Finally, it jumps back to the beginning of the loop. Once the loop finishes, the program halts with the final sum in $1.

### Question 2: Average Load Word Time

To find the processor's average time per `lw` instruction, we can use the formula for Average Memory Access Time (AMAT):

AMAT=(Hit Rate×Hit Time)+(Miss Rate×Miss Penalty)

Given:

- Cache Access Time (Hit Time) = 4ns
- Main Memory Access Time = 40ns
- Hit Rate = 98% = 0.98

First, calculate the Miss Rate:

Miss Rate = 1 - Hit Rate = 1 - 0.98 = 0.02

Next, calculate the Miss Penalty. The miss penalty is the _additional_ time required on a miss compared to a hit. When a miss occurs, we first access the cache (which takes 4ns) and then access main memory (which takes 40ns). The total time for a miss is 4ns + 40ns = 44ns. The miss penalty is the difference between the miss time and the hit time, but often in AMAT calculations, the "Miss Penalty" term refers to the time it takes to get the data from the next level of memory _after_ the cache access has already failed. In this context, accessing main memory takes 40ns. So, the time cost of a miss _relative to starting the access_ is the cache access time plus the main memory access time (4ns + 40ns = 44ns). The formula can also be expressed as:

AMAT=Hit Time+(Miss Rate×Time to access main memory after miss)

AMAT=4ns+(0.02×40ns)

AMAT=4ns+0.8ns

AMAT=4.8ns

Alternatively, using the total time for hit and miss:

AMAT=(0.98×4ns)+(0.02×(4ns+40ns))

AMAT=(0.98×4ns)+(0.02×44ns)

AMAT=3.92ns+0.88ns

AMAT=4.8ns

Therefore, the processor's average time per `lw` instruction is 4.8 nanoseconds.

### Question 3: Cache Write Policies in Multiprocessor Systems

In a multiprocessor system where processors have their own L1 caches but share main RAM, the choice between write-through and write-back cache policies has significant implications for maintaining data consistency across the caches, a problem known as cache coherence.

- **Write-Through:** In a write-through policy, every write operation updates both the cache line and the corresponding location in main memory simultaneously.
    
    - **Potential Problems/Complications:** While simple, write-through can generate significant bus traffic to main memory, potentially creating a bottleneck, especially with multiple processors writing frequently. More critically for coherence, if Processor 1 writes to a location X using write-through, main memory is updated. However, if Processor 2 has an older copy of location X in its cache, it becomes stale (inconsistent) until Processor 2 reads the updated value from main memory. The policy itself doesn't automatically invalidate other caches.
    - **Mitigation Strategy:** Cache coherence protocols, like snooping protocols (e.g., MESI), are essential. With write-through, when a processor writes to memory, other caches can "snoop" the memory bus. If they detect a write to a block they hold, they can invalidate their copy, forcing a read from memory on the next access to ensure consistency.
- **Write-Back:** In a write-back policy, writes only update the cache line initially. The modified cache line (now marked as "dirty") is written back to main memory only when the cache line is replaced (evicted).
    
    - **Potential Problems/Complications:** Write-back reduces memory bus traffic compared to write-through, but complicates cache coherence significantly. If Processor 1 modifies block X in its cache (making it dirty) and Processor 2 tries to read block X from main memory, it will get stale data because the up-to-date version is only in Processor 1's cache. Furthermore, if Processor 2 then tries to _write_ to block X, potential data corruption could occur.
    - **Mitigation Strategy:** Coherence protocols are crucial here as well. Snooping protocols can be used. When Processor 2 requests block X from memory, Processor 1's cache controller snoops this request. If it has a dirty copy of block X, it must intervene. It can either write the dirty block back to main memory _before_ memory responds to Processor 2, or it can directly supply the data to Processor 2 (cache-to-cache transfer) and potentially update memory simultaneously or later. Protocols like MESI manage states (Modified, Exclusive, Shared, Invalid) for cache lines to handle these interactions correctly, ensuring only one processor has write permission (Modified or Exclusive state) at a time, or that shared copies are read-only (Shared state).

In summary, write-back offers better performance by reducing memory traffic but requires more complex coherence protocols to handle inconsistencies arising from dirty data residing only in one cache. Write-through simplifies coherence slightly (memory is always _intended_ to be up-to-date, though other caches might be stale) but can lead to performance issues due to high memory traffic. Both require explicit coherence mechanisms like snooping protocols to function correctly in a shared-memory multiprocessor system.

### Question 4: Cache Calculations

Given:

- Processor Speed: 3GHz (3×109 cycles/second)
- Cycle Time: 1/(3×109Hz)=1/3 ns
- Address Size: 64 bits
- L1 Cache Size: 512KB (512×210 bytes)
- L2 Cache Size: 4MB (4×220 bytes)
- Block Size (both caches): 512 bytes (29 bytes)
- Mapping (both caches): Direct-mapped
- Memory Cell Size: 1 byte
- L1 Reference (hit or miss) in one cycle (if hit assumed, else involves penalties)
- L2 Cache Penalty: 10ns
- Main Memory Penalty: 100ns
- Instruction Mix: 10% L1 ref, 5% L2 ref, 3% Main Memory ref

**(a) Tag Size Calculation**

For any cache, Address Size = Tag Bits + Index Bits + Offset Bits.

- Offset Bits: Determined by Block Size.
    
    Offset Bits = log2​(Block Size)=log2​(512)=log2​(29)=9 bits.
    
- Index Bits (L1): Determined by the number of blocks/sets in the cache. For direct-mapped, this is the number of blocks (rows).
    
    Number of L1 Blocks = L1 Cache Size / Block Size = (512×210 bytes)/(512 bytes/block)=210=1024 blocks.
    
    L1 Index Bits = log2​(Number of L1 Blocks)=log2​(1024)=log2​(210)=10 bits.
    
- Tag Bits (L1):
    
    L1 Tag Bits = Address Size - L1 Index Bits - Offset Bits = 64 - 10 - 9 = 45 bits.
    
- Index Bits (L2):
    
    Number of L2 Blocks = L2 Cache Size / Block Size = (4×220 bytes)/(512 bytes/block)=(22×220)/29=222/29=213=8192 blocks.
    
    L2 Index Bits = log2​(Number of L2 Blocks)=log2​(8192)=log2​(213)=13 bits.
    
- Tag Bits (L2):
    
    L2 Tag Bits = Address Size - L2 Index Bits - Offset Bits = 64 - 13 - 9 = 42 bits.
    

So, the L1 tag is 45 bits, and the L2 tag is 42 bits.

**(b) Total Cache Size Calculation**

Total Size = Number of Blocks * (Block Size + Tag Size + Valid Bit Size)

Assume Valid Bit Size = 1 bit. Block Size = 512 bytes = 512×8=4096 bits.

- Total L1 Size:
    
    Total L1 Size = Number of L1 Blocks * (Block Size bits + L1 Tag Bits + 1)
    
    Total L1 Size = 1024×(4096+45+1) bits
    
    Total L1 Size = 1024×4142 bits
    
    Total L1 Size = 4,241,408 bits
    
- Total L2 Size:
    
    Total L2 Size = Number of L2 Blocks * (Block Size bits + L2 Tag Bits + 1)
    
    Total L2 Size = 8192×(4096+42+1) bits
    
    Total L2 Size = 8192×4139 bits
    
    Total L2 Size = 33,906,688 bits
    

The total actual size is 4,241,408 bits for the L1 cache and 33,906,688 bits for the L2 cache.

**(c) Average CPI Calculation**

First, convert time penalties to cycles:

- Processor Frequency = 3GHz = 3 cycles/ns.
- L2 Penalty Cycles = 10 ns * 3 cycles/ns = 30 cycles.
- Main Memory Penalty Cycles = 100 ns * 3 cycles/ns = 300 cycles.
- Non-memory instructions and L1 hits take 1 cycle.

Instruction Mix Interpretation: The percentages seem to describe the final destination of a memory request for _all_ instructions, not just memory instructions.

- 3% of all instructions access main memory (L1 miss, L2 miss).
- 5% of all instructions access L2 (meaning L1 miss, L2 hit or L2 miss). Since 3% miss L2, then 5% - 3% = 2% must hit L2 (L1 miss, L2 hit).
- 10% of all instructions result in an L1 reference (hit or miss). Since 5% miss L1 (2% L2 hit + 3% Mem hit), then 10% - 5% = 5% must hit L1.
- The remaining instructions (100% - 10% = 90%) must be non-memory instructions. Let's verify the 10% L1 reference: 5% L1 Hit + 2% L2 Hit (L1 miss) + 3% Mem Hit (L1 miss, L2 miss) = 10% total involves L1. This seems consistent.

Calculate Average CPI:

CPI = (%Non-Mem×Cycles)+(%L1 Hit×Cycles)+(%L2 Hit×Cycles)+(%Mem Hit×Cycles)

- Cycles for Non-Memory = 1 cycle
- Cycles for L1 Hit = 1 cycle
- Cycles for L2 Hit = 1 cycle (L1 access) + 30 cycles (L2 penalty) = 31 cycles
- Cycles for Memory Hit = 1 cycle (L1 access) + 30 cycles (L2 penalty) + 300 cycles (Mem penalty) = 331 cycles

CPI = (0.90×1)+(0.05×1)+(0.02×31)+(0.03×331)

CPI = 0.90+0.05+(0.02×31)+(0.03×331)

CPI = 0.90+0.05+0.62+9.93

CPI = 11.50

The average CPI is 11.50.

### Question 5: Cache Tracing

Sequence of memory byte addresses (hex): 40, 47, 50, 42, 81, 83, 85, 57, 46.

Cache Capacity = 32 bytes. LRU replacement for associative caches.

**(a) Direct mapped cache, block size = 4 bytes**

- Number of blocks = 32 / 4 = 8 blocks.
- Index bits = log2​(8)=3. Offset bits = log2​(4)=2.
- Address format (binary): ...Tag | Index (3 bits) | Offset (2 bits)
- Index = (Address / Block Size) % Number of Blocks = (Address >> 2) % 8

|            |                   |                   |                      |                 |                 |               |            |                                    |
| ---------- | ----------------- | ----------------- | -------------------- | --------------- | --------------- | ------------- | ---------- | ---------------------------------- |
| **Access** | **Address (Hex)** | **Address (Bin)** | **Block Addr (Hex)** | **Index (Bin)** | **Index (Dec)** | **Tag (Bin)** | **H/M/ME** | **Cache State (Tag @ Index)**      |
| 1          | 40                | 0100 00**00**     | 40                   | 000             | 0               | 010           | M          | @0: 010                            |
| 2          | 47                | 0100 01**11**     | 44                   | 001             | 1               | 010           | M          | @0: 010, @1: 010                   |
| 3          | 50                | 0101 00**00**     | 50                   | 100             | 4               | 010           | M          | @0: 010, @1: 010, @4: 010          |
| 4          | 42                | 0100 00**10**     | 40                   | 000             | 0               | 010           | H          | @0: 010, @1: 010, @4: 010          |
| 5          | 81                | 1000 00**01**     | 80                   | 000             | 0               | 100           | ME         | @0: 100, @1: 010, @4: 010          |
| 6          | 83                | 1000 00**11**     | 80                   | 000             | 0               | 100           | H          | @0: 100, @1: 010, @4: 010          |
| 7          | 85                | 1000 01**01**     | 84                   | 001             | 1               | 100           | ME         | @0: 100, @1: 100, @4: 010          |
| 8          | 57                | 0101 01**11**     | 54                   | 101             | 5               | 010           | M          | @0: 100, @1: 100, @4: 010, @5: 010 |
| 9          | 46                | 0100 01**10**     | 44                   | 001             | 1               | 010           | ME         | @0: 100, @1: 010, @4: 010, @5: 010 |

Result Table (a):

| Addr | 40h | 47h | 50h | 42h | 81h | 83h | 85h | 57h | 46h |

| :----------- | :-- | :-- | :-- | :-- | :-- | :-- | :-- | :-- | :-- |

| H, M, or ME? | M | M | M | H | ME | H | ME | M | ME |

**Hit ratio (a):** 2 Hits / 9 Accesses = 2/9 ≈ 22.2%

**(b) Fully associative cache, block size = 4 bytes**

- Number of blocks = 32 / 4 = 8 blocks.
- No index bits. Offset bits = log2​(4)=2. LRU replacement.
- Tag = Address / Block Size = Address >> 2

|            |                   |                      |               |            |                                                     |
| ---------- | ----------------- | -------------------- | ------------- | ---------- | --------------------------------------------------- |
| **Access** | **Address (Hex)** | **Block Addr (Hex)** | **Tag (Hex)** | **H/M/ME** | **Cache State (Tags stored, LRU order: MRU...LRU)** |
| 1          | 40                | 40                   | 10            | M          | [10]                                                |
| 2          | 47                | 44                   | 11            | M          | [11, 10]                                            |
| 3          | 50                | 50                   | 14            | M          | [14, 11, 10]                                        |
| 4          | 42                | 40                   | 10            | H          | [10, 14, 11]                                        |
| 5          | 81                | 80                   | 20            | M          | [20, 10, 14, 11]                                    |
| 6          | 83                | 80                   | 20            | H          | [20, 10, 14, 11]                                    |
| 7          | 85                | 84                   | 21            | M          | [21, 20, 10, 14, 11]                                |
| 8          | 57                | 54                   | 15            | M          | [15, 21, 20, 10, 14, 11]                            |
| 9          | 46                | 44                   | 11            | H          | [11, 15, 21, 20, 10, 14]                            |

Result Table (b):

| Addr | 40h | 47h | 50h | 42h | 81h | 83h | 85h | 57h | 46h |

| :----------- | :-- | :-- | :-- | :-- | :-- | :-- | :-- | :-- | :-- |

| H, M, or ME? | M | M | M | H | M | H | M | M | H |

**Hit ratio (b):** 3 Hits / 9 Accesses = 3/9 = 1/3 ≈ 33.3%

**(c) Direct mapped cache, block size = 8 bytes**

- Number of blocks = 32 / 8 = 4 blocks.
- Index bits = log2​(4)=2. Offset bits = log2​(8)=3.
- Address format (binary): ...Tag | Index (2 bits) | Offset (3 bits)
- Index = (Address / Block Size) % Number of Blocks = (Address >> 3) % 4

|            |                   |                   |                      |                 |                 |               |            |                               |
| ---------- | ----------------- | ----------------- | -------------------- | --------------- | --------------- | ------------- | ---------- | ----------------------------- |
| **Access** | **Address (Hex)** | **Address (Bin)** | **Block Addr (Hex)** | **Index (Bin)** | **Index (Dec)** | **Tag (Bin)** | **H/M/ME** | **Cache State (Tag @ Index)** |
| 1          | 40                | 0100 00**00**0    | 40                   | 00              | 0               | 01000         | M          | @0: 01000                     |
| 2          | 47                | 0100 01**11**0    | 40                   | 00              | 0               | 01000         | H          | @0: 01000                     |
| 3          | 50                | 0101 00**00**0    | 50                   | 10              | 2               | 01010         | M          | @0: 01000, @2: 01010          |
| 4          | 42                | 0100 00**10**0    | 40                   | 00              | 0               | 01000         | H          | @0: 01000, @2: 01010          |
| 5          | 81                | 1000 00**01**0    | 80                   | 00              | 0               | 10000         | ME         | @0: 10000, @2: 01010          |
| 6          | 83                | 1000 00**11**0    | 80                   | 00              | 0               | 10000         | H          | @0: 10000, @2: 01010          |
| 7          | 85                | 1000 01**01**0    | 80                   | 00              | 0               | 10000         | H          | @0: 10000, @2: 01010          |
| 8          | 57                | 0101 01**11**0    | 50                   | 10              | 2               | 01010         | H          | @0: 10000, @2: 01010          |
| 9          | 46                | 0100 01**10**0    | 40                   | 00              | 0               | 01000         | ME         | @0: 01000, @2: 01010          |

Result Table (c):

| Addr | 40h | 47h | 50h | 42h | 81h | 83h | 85h | 57h | 46h |

| :----------- | :-- | :-- | :-- | :-- | :-- | :-- | :-- | :-- | :-- |

| H, M, or ME? | M | H | M | H | ME | H | H | H | ME |

**Hit ratio (c):** 5 Hits / 9 Accesses = 5/9 ≈ 55.6%

**(d) Two-way set associative cache, block size = 8 bytes**

- Block Size = 8 bytes (23). Offset bits = 3.
- Total Blocks = 32 / 8 = 4 blocks.
- Number of Sets = Total Blocks / Ways = 4 / 2 = 2 sets.
- Index bits = log2​(Number of Sets)=log2​(2)=1.
- Address format (binary): ...Tag | Index (1 bit) | Offset (3 bits)
- Index = (Address / Block Size) % Number of Sets = (Address >> 3) % 2
- LRU within each set.

|            |                |                 |                      |                 |                 |               |            |                                       |                                       |
| ---------- | -------------- | --------------- | -------------------- | --------------- | --------------- | ------------- | ---------- | ------------------------------------- | ------------------------------------- |
| **Access** | **Addr (Hex)** | **Addr (Bin)**  | **Block Addr (Hex)** | **Index (Bin)** | **Index (Dec)** | **Tag (Bin)** | **H/M/ME** | **Set 0 State (Tags, LRU: MRU..LRU)** | **Set 1 State (Tags, LRU: MRU..LRU)** |
| 1          | 40             | 0100 00**0**000 | 40                   | 0               | 0               | 010000        | M          | [010000]                              | []                                    |
| 2          | 47             | 0100 01**1**111 | 40                   | 0               | 0               | 010000        | H          | [010000]                              | []                                    |
| 3          | 50             | 0101 00**0**000 | 50                   | 0               | 0               | 010100        | M          | [010100, 010000]                      | []                                    |
| 4          | 42             | 0100 00**1**010 | 40                   | 0               | 0               | 010000        | H          | [010000, 010100]                      | []                                    |
| 5          | 81             | 1000 00**0**100 | 80                   | 0               | 0               | 100000        | ME         | [100000, 010000]                      | []                                    |
| 6          | 83             | 1000 00**1**101 | 80                   | 0               | 0               | 100000        | H          | [100000, 010000]                      | []                                    |
| 7          | 85             | 1000 01**0**101 | 80                   | 0               | 0               | 100000        | H          | [100000, 010000]                      | []                                    |
| 8          | 57             | 0101 01**1**110 | 50                   | 1               | 1               | 010101        | M          | [100000, 010000]                      | [010101]                              |
| 9          | 46             | 0100 01**1**000 | 40                   | 1               | 1               | 010001        | M          | [100000, 010000]                      | [010001, 010101]                      |

Result Table (d):

| Addr | 40h | 47h | 50h | 42h | 81h | 83h | 85h | 57h | 46h |

| :----------- | :-- | :-- | :-- | :-- | :-- | :-- | :-- | :-- | :-- |

| H, M, or ME? | M | H | M | H | ME | H | H | M | M |

**Hit ratio (d):** 4 Hits / 9 Accesses = 4/9 ≈ 44.4%

### Question 6: L1/L2 Cache Trace

System:

- L1: Fully associative, 2 blocks total, block size = 4 cells, LRU.
    - Offset bits = log2​(4)=2. Tag = Address >> 2.
- L2: Direct-mapped, 2 rows, block size = 8 cells.
    - Offset bits = log2​(8)=3. Index bits = log2​(2)=1.
    - Index = (Address >> 3) % 2. Tag = Address >> (3+1) = Address >> 4.
- Addresses are decimal. Check L2 only on L1 miss.

|                |                  |            |                                    |                  |                  |            |                        |                                                                                                                                                                                                        |
| -------------- | ---------------- | ---------- | ---------------------------------- | ---------------- | ---------------- | ---------- | ---------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| **Addr (Dec)** | **L1 Tag (Dec)** | **L1 h/m** | **L1 State (Tags, LRU: MRU..LRU)** | **L2 Row (Dec)** | **L2 Tag (Dec)** | **L2 h/m** | **L2 State (Tag@Row)** | **Notes**                                                                                                                                                                                              |
| 53             | 13               | m          | [13]                               | 1                | 3                | m          | @1: 3                  | 53>>2=13; 53>>3=6; 6%2=0->Row0? Nope 53=(35)_16=(0011 0101)_2 Offset=01, Index=0 -> Row 0. Ah, 53 = (1101**01**)_2, L1Tag=(1101)_2=13. 53 = (110**1**01)_2, L2 Offset=101, L2 Index=1, L2 Tag=(11)_2=3 |
| 50             | 12               | m          | [12, 13]                           | 0                | 3                | m          | @1: 3, @0: 3           | 50>>2=12; 50>>3=6; 6%2=0. L2 Tag=50>>4=3                                                                                                                                                               |
| 52             | 13               | h          | [13, 12]                           | -                | -                | -          | @1: 3, @0: 3           | L1 Hit                                                                                                                                                                                                 |
| 40             | 10               | m          | [10, 13] (Evicts 12)               | 0                | 2                | m          | @1: 3, @0: 2           | 40>>2=10; 40>>3=5; 5%2=1. L2 Tag=40>>4=2. Wait, 40>>3=5, 5%2=1 -> Row 1? 40=(101000)_2. L2 Off=000, L2 Idx=0, L2 Tag=10. Row 0. Tag=2. Correct. Evicts L2@0:3.                                         |
| 60             | 15               | m          | [15, 10] (Evicts 13)               | 1                | 3                | h          | @1: 3, @0: 2           | 60>>2=15; 60>>3=7; 7%2=1. L2 Tag=60>>4=3. L2 Hit.                                                                                                                                                      |
| 152            | 38               | m          | [38, 15] (Evicts 10)               | 1                | 9                | m          | @1: 9, @0: 2           | 152>>2=38; 152>>3=19; 19%2=1. L2 Tag=152>>4=9. Evicts L2@1:3.                                                                                                                                          |

**Completed Table:**

|          |            |            |            |            |            |
| -------- | ---------- | ---------- | ---------- | ---------- | ---------- |
| **Addr** | **L1 tag** | **L1 h/m** | **L2 row** | **L2 tag** | **L2 h/m** |
| 53       | 13         | m          | 1          | 3          | m          |
| 50       | 12         | m          | 0          | 3          | m          |
| 52       | 13         | h          | -          | -          | -          |
| 40       | 10         | m          | 0          | 2          | m          |
| 60       | 15         | m          | 1          | 3          | h          |
| 152      | 38         | m          | 1          | 9          | m          |
