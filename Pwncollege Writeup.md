_by Vaughn Valle_

Username: `vqv9731`, profile link [here](https://pwn.college/hacker/)
## Process
For each of the Pwncollege challenges below, the following process was done to execute assembly code:

```bash
nvim assembly.s # Then add assembly lines
as -o assembly.o assembly.s # Compile source to obj .o
objcopy -O binary --only-section=.text asm.o asm.bin # Copy .text to binary
cat ./asm.bin | /challenge/run # Pipe bin output into chal as instructed
```

All assembly code was written in the (superior) **Intel syntax** 
## 1 Set Register
Here we are merely moving `0x1337` to the `rdi` register
```nasm
.intel_syntax noprefix
mov rdi, 1337h
```

## 2 Set Multiple Registers
Here it is the same as the previous chal but with 3 registers that need setting 
```nasm
.intel_syntax noprefix
mov rax, 1337h
mov r12, cafed00d1337beefh
mov rsp, 31337h
```

## 3 Add To Register
Here we use the `add` operator to add `0x331337` to what's currently in `rdi`
```nasm
.intel_syntax noprefix
add rdi, 331337h
```

## 4 Linear Equation Registers
Here we are tasked to compute:
$$
f(x)=mx+b
$$
where 
- `m = rdi` 
- `x = rsi` 
- `b = rdx`

We create the `mx` term via `imul`, then add `b` via the `add` line, to create `mx+b` moved to `rax` as instructed
```nasm
.intel_syntax noprefix
imul rsi, rdi
add rsi, rdx
mov rax, rsi
```
## 5 Integer Division
Here we are merely computing for speed:
$$
speed=\frac{distance}{time}
$$
where
- `distance = rdi`
- `time = rsi`
- `speed = rax`

We can move `rdi` to `rax` via `mov`, then divide `rax` with `time` in `rsi`
```nasm
.intel_syntax noprefix
mov rax, rdi
div rsi
```

## 6 Modulo Operation
In this chal, we are tasked to replicate the modulo operation. Luckily, x86 allows us to get the remainder after any `div` operation

We are asked to compute `rdi % rsi`. We can achieve this by taking advantage of x86 storing remainder in `rdx` for any 64-bit reg division
```nasm
.intel_syntax noprefix
mov rax, rdi
div rsi
mov rax, rdx
```

## 7 Set Upper Byte
Recall that `ah` register contains the upper 8 bits of the `ax` register. This figure helps
![[Pasted image 20241221011100.png]]
Our constraint for this challenge is that we can only perform one `mov` operation. Hence we can set the upper 8 bits of `ax` to `0x42` with
```nasm
.intel_syntax noprefix
mov ah, 42h
```

## 8 Efficient Modulo
Here we are tasked to compute
- `rax = rdi % 256`, and
- `rbx = rsi % 65536`
using only one `mov` instruction

We are told that the `div` operator is slow to compute modulus. However, the result of any modulus operation `x % y` such that `y` is a power of 2 ($2^n$), is stored in the lower `n` bits of x.

Recall that 
- `al` contains the lower 8 bits of `rax`
- `dil` contains the lower 8 bits of `rdi`
- `bx` contains the lower 16 bits of `rbx`, and
- `si` contains the lower 16 bits of `rsi`

With these lower bit registers, let's take advantage of lower-byte access to compute modulus:
```nasm
.intel_syntax noprefix
mov al, dil
mov bx, si
```

## 9 Byte Extraction
We are tasked to shift bits using only `mov, shr, shl`.

To put simply, since we are shifting 3 times to the left and 7 times to the right to set `rax` to the 5th LSB of `rdi`
```nasm
.intel_syntax noprefix
shl rdi, 24
shr rdi, 56
mov rax, rdi
```
## 10 Bitwise And
Here we are tasked to set `rax` to the value of `rdi && rsi`

This challenge requires performing a bitwise AND operation between two registers, rdi and rsi, and storing the result in rax. The solution involves two instructions: `and rdi, rsi` to perform the AND operation and `and rax, rdi` to cleverly extract the result into rax by utilizing the initial state of rax (likely all 1s).

```nasm
.intel_syntax noprefix
AND rax, rdi
AND rax, rsi
```
## 11 Check Even

This challenge aims to determine if the value in rdi is even or odd. The solution involves a series of instructions:

1. `xor rax, rax` clears rax.
2. `or rax, 0x1` sets the least significant bit of rax to 1.
3. `and rax, rdi` checks if the least significant bit of rdi is 1 (odd).
4. `xor al, 1` inverts the result to get the desired even/odd indication (even: 1, odd: 0).
```nasm
.intel_syntax noprefix
and dil, al
and rax, 1
xor al, 1
```
## 12 Memory Read

This challenge involves reading the value from a specific memory address (0x404000) into rax. The solution is straightforward: `mov rax, [0x404000]` directly reads the value from the memory address into rax.
```nasm
.intel_syntax noprefix
mov rax, [0x404000]
```
## 13 Memory Write

This challenge requires writing the value in rax to a specific memory address (0x404000). The solution is achieved with a single instruction: `mov [0x404000], rax` directly writes the value from rax to the memory address.
```nasm
.intel_syntax noprefix
mov [0x404000], rax
```
## 14 memory-increment

This challenge aims to increment the value at memory address 0x404000 by 0x1337. The solution involves the following steps:

1. `mov rax, qword ptr [0x404000]` reads the current value pointer from memory into rax.
4. `add qword ptr [0x404000], 1337h` adds `0x1337` to our current value pointer
```nasm
.intel_syntax noprefix
mov rax, qword ptr[0x404000]
add qword ptr [0x404000], 1337h
```
## 15 byte-access

This challenge requires reading only the least significant byte from memory address 0x404000 into rax. The solution involves:

- `mov al, byte ptr [0x404000]` reads only the least significant byte from a pointer into the al register (lower byte of rax).
```nasm
.intel_syntax noprefix
mov al, byte ptr [0x404000]
```
## 16 memory-size-access

This challenge involves reading the value from memory address 0x404000 into different registers with varying sizes (byte, word, doubleword, quadword). The solution involves:

```nasm
.intel_syntax noprefix
mov rax, [0x404000]
```

## 17 little-endian-write

This challenge requires writing specific values to memory locations pointed to by rdi and rsi. The solution involves:

1. `mov rax, 0xdeadbeef00001337`: Loads the first value into rax.
2. `mov [rdi], rax`: Writes the value to the memory location pointed to by rdi.
4. `mov rax, 0xc0ffee0000`: Loads the second value into rax.
5. `mov [rsi], rax`: Writes the value to the memory location pointed to by rsi.
```nasm
.intel_syntax noprefix
mov rax, 0xdeadbeef00001337
mov [rdi], rax
xor rax, rax
mov rax, 0xc0ffee0000
mov [rsi], rax
```

## 18 memory-sum

This challenge aims to calculate the sum of two quadwords located at consecutive memory addresses pointed to by rdi and store the result at the address pointed to by rsi. The solution involves:

1. `mov rax, [rdi]`: Reads the first quadword.
2. `mov rdx, [rdi+8]`: Reads the second quadword.
3. `add rax, rdx`: Calculates the sum.
4. `mov [rsi], rax`: Stores the result at the address pointed to by rsi.
```nasm
.intel_syntax noprefix
mov rax, [rdi]
mov rdx, [rdi+8]
add rax, rdx
mov [rsi], rax
```
## 19 stack-subtraction

This challenge requires popping a value from the stack, subtracting rdi from it, and pushing the result back onto the stack. The solution involves:

1. `pop rax`: Pops the top value from the stack into rax.
2. `sub rax, rdi`: Subtracts rdi from the popped value.
3. `push rax`: Pushes the result back onto the stack.
```nasm
.intel_syntax noprefix
pop rax
sub rax, rdi
push rax
```
## 20 swap-stack-values

This challenge aims to swap the top two values on the stack. The solution involves:

1. `push rdi`: Pushes rdi onto the stack.
2. `push rsi`: Pushes rsi onto the stack (rsi is now on top).
3. `pop rdi`: Pops the top value (rsi) into rdi.
4. `pop rsi`: Pops the remaining value (original rdi) into rsi.
```nasm
.intel_syntax noprefix
push rdi
push rsi
pop rdi
pop rsi
```
## 21 average-stack-values

This challenge requires calculating the average of the top four quadwords on the stack and pushing the result onto the stack. The solution involves:

1. `add rax, [rsp]`: Adds the first quadword on the stack to rax.
2. `add rax, [rsp+8]`: Adds the second quadword.
3. `add rax, [rsp+16]`: Adds the third quadword.
4. `add rax, [rsp+24]`: Adds the fourth quadword.
5. `mov rdi, 0x4`: Loads the divisor (4) into rdi.
6. `div rdi`: Divides the sum in rax by 4.
7. `push rax`: Pushes the calculated average onto the stack.

```nasm
.intel_syntax noprefix
add rax, [rsp]
add rax, [rsp+8]
add rax, [rsp+16]
add rax, [rsp+24]
mov rdi, 0x4
div rdi
push rax
```

## 22 absolute-jump

This challenge requires performing an absolute jump to a specific memory address. The solution involves:

1. `mov rdi, 0x403000`: Loads the target address into rdi.
2. `jmp rdi`: Jumps to the address in rdi.
```nasm
.intel_syntax noprefix
mov rdi, 0x403000
jmp rdi
```
## 23 relative-jump
This challenge requires performing a relative jump to a specific location within the code. We are tasked to make a relative jump to `0x51` bytes from the current position and then set `rax` to `0x1` when we redirect control flow
```nasm
.intel_syntax noprefix
.rept 0x50
nop
.endr
jmp here

here:
mov rax, 0x1
```
## 24 jump-trampoline
This challenge appears to involve control flow manipulation and stack interaction. This is very similar to the previous chal but with an absolute address of `0x403000`
```nasm
.intel_syntax noprefix
.rept 0x50
nop
.endr
jmp jump

jump:
mov rdi, [rsp]
mov rax, 0x403000
jmp rax
```

## 25 conditional-jump
We are tasked to implement the following:

```plaintext
if [x] is 0x7f454c46:
    y = [x+4] + [x+8] + [x+12]
else if [x] is 0x00005A4D:
    y = [x+4] - [x+8] - [x+12]
else:
    y = [x+4] * [x+8] * [x+12]
```

Where:
- `x = rdi`, `y = rax`.

This challenge presented us with a simple program that performed different arithmetic operations based on the value at a given memory address. The core logic was implemented in the following assembly code:

```nasm
.intel_syntax noprefix
mov eax, [rdi]
mov ebx, [rdi+4]
mov ecx, [rdi+8]
mov edx, [rdi+12]

cmp eax, 0x7f454c46
je condition1
cmp eax, 0x5A4D
je condition2

imul ebx, ecx
imul ebx,edx
jmp done

condition1:
add ebx, ecx
add ebx, edx
jmp done

condition2:
sub ebx, ecx
sub ebx, edx
jmp done

done:
mov eax, ebx
```
The code reads four 4-byte values from memory, starting at the address in `rdi`. It then checks the first 4-byte value (`[rdi]`) against two magic numbers:

- `0x7f454c46`: If this value is found (the magic bytes for an ELF file - `\x7fELF`), it performs addition: `y = [rdi+4] + [rdi+8] + [rdi+12]`.
- `0x5A4D`: If this value is found (the magic bytes for a DOS MZ executable - `MZ`), it performs subtraction: `y = [rdi+4] - [rdi+8] - [rdi+12]`.
- Otherwise, it performs multiplication: `y = [rdi+4] * [rdi+8] * [rdi+12]`.

The result is stored in `eax` (and implicitly returned).
## 26 indirect-jump
We are tasked to implement the following logic:

```plaintext
if rdi is 0:
  jmp 0x40301e
else if rdi is 1:
  jmp 0x4030da
else if rdi is 2:
  jmp 0x4031d5
else if rdi is 3:
  jmp 0x403268
else:
  jmp 0x40332c
```

We also have the following constraints for this challenge:
- Assume `rdi` will NOT be negative.
- Use no more than 1 `cmp` instruction.
- Use no more than 3 jumps (of any variant).
- We will provide you with the number to 'switch' on in `rdi`.
- We will provide you with a jump table base address in `rsi`.

```nasm
.intel_syntax noprefix
cmp rdi, 3
jg greater
jmp [rsi+rdi*0x8]

greater:
jmp [rsi+0x20]
```
A jump table is an array of memory addresses. By indexing into this array, we can jump to different locations based on a value. In this case, each entry in the jump table is 8 bytes (64-bit address).
1. **`cmp rdi, 3`**: This single comparison checks if `rdi` is greater than 3. This efficiently handles the `else` case in the original logic.
2. **`jg greater`**: If `rdi` is greater than 3, the code jumps to the `greater` label.
3. **`jmp [rsi+rdi*0x8]`**: This is the core of the jump table dispatch. `rsi` holds the base address of the jump table. `rdi` is the index into the table. Multiplying `rdi` by 8 (0x8) calculates the correct offset into the table, as each entry is 8 bytes. The `jmp` instruction then jumps to the address stored at that calculated memory location. This single instruction handles the cases where `rdi` is 0, 1, 2, or 3.
4. **`greater:`**: This label marks the code for the `else` case (when `rdi > 3`).
5. **`jmp [rsi+0x20]`**: Since each entry is 8 bytes, and we want to jump to the 5th entry (index 4) for the `else` case, we add 0x20 (4 * 8) to `rsi`, effectively jumping to the correct default address.

This solution elegantly satisfies all the constraints. It uses only one comparison, three jumps, and effectively implements the desired dispatch logic using a jump table. The jump table at `rsi` would have the following structure:

```
[rsi + 0x00]: 0x40301e
[rsi + 0x08]: 0x4030da
[rsi + 0x10]: 0x4031d5
[rsi + 0x18]: 0x403268
[rsi + 0x20]: 0x40332c
```
This setup ensures that the correct jump occurs based on the value in `rdi`.
## 27 average-loop
In this challenge, we are tasked to compute the average of `n` consecutive quad words, where:
- `rdi` = memory address of the 1st quad word
- `rsi` = `n` (amount to loop for)
- `rax` = average computed

```nasm
.intel_syntax noprefix

xor rax,rax
mov rbx, 0

loop:
cmp rsi, rbx
je calc
add rax, [rdi+rbx*0x8]
inc rbx
jmp loop

calc:
div rax, rsi
```
This challenge involved calculating the average of `n` consecutive 64-bit (quad word) values stored in memory. The address of the first quad word was provided in `rdi`, and the number of quad words (`n`) was in `rsi`. The calculated average was expected to be returned in `rax`. The provided assembly code iterated through the quad words, accumulating their sum in `rax`. A loop counter, `rbx`, was used to track the current iteration. Inside the loop, the value at the memory location `rdi + rbx * 8` was added to the running sum in `rax`. The multiplication by 8 accounted for the size of each quad word. Once the loop completed (when `rbx` equaled `rsi`), the accumulated sum in `rax` was divided by `rsi` using the `div` instruction, effectively calculating the average. The result of this division, the average, was then stored in `rax`.
## 28 count-non-zero
Here, we are tasked to count the consecutive non-zero bytes in a contiguous region of memory, where:
- `rdi` = memory address of the 1st byte
- `rax` = number of consecutive non-zero bytes
Additionally, if `rdi = 0`, then we should set `rax = 0`
```nasm
.intel_syntax noprefix
cmp rdi, 0
je zero
jmp loop

loop:
cmp dword ptr [rdi+rax], 0
je end
inc rax
jmp loop

zero:
xor rax, rax

end:
```
This challenge focused on counting consecutive non-zero bytes within a contiguous memory region. The starting memory address was provided in `rdi`, and the count of consecutive non-zero bytes was to be returned in `rax`. A special case was implemented: if `rdi` was 0, `rax` was explicitly set to 0. The assembly code first checked if `rdi` was zero; if so, `rax` was zeroed out, and the program jumped to the `end`. Otherwise, the program entered a loop. Inside this loop, a byte at the address `rdi + rax` was compared to zero. If the byte was zero, the loop terminated and jumped to the `end`. If the byte was non-zero, the counter `rax` was incremented, and the loop continued, checking the next consecutive byte. This process continued until a zero byte was encountered or the end of the accessible memory was reached (although this was not explicitly checked in the provided code). Finally, the accumulated count in `rax` represented the number of consecutive non-zero bytes, and the program exited at the `end` label.
## 29 string-lower
We are tasked to implement the following logic:
```plaintext
str_lower(src_addr):
  i = 0
  if src_addr != 0:
    while [src_addr] != 0x00:
      if [src_addr] <= 0x5a:
        [src_addr] = foo([src_addr])
        i += 1
      src_addr += 1
  return i
```
`foo` is provided at `0x403000`. `foo` takes a single argument as a value and returns a value.

All functions (`foo` and `str_lower`) must follow the Linux amd64 calling convention (also known as System V AMD64 ABI): [System V AMD64 ABI](https://en.wikipedia.org/wiki/X86_calling_conventions#System_V_AMD64_ABI)

Therefore, your function `str_lower` should look for `src_addr` in `rdi` and place the function return in `rax`.

An important note is that `src_addr` is an address in memory (where the string is located) and `[src_addr]` refers to the byte that exists at `src_addr`.

Therefore, the function `foo` accepts a byte as its first argument and returns a byte.
```nasm
.intel_syntax noprefix

lower:
mov r10, 0x0
cmp rdi, 0x0
je skip

loop:
mov rbx, rdi
mov rax, 0x403000
xor rdi, rdi
mov dil, byte ptr[rbx]
cmp dil, 0x0
je skip
cmp dil, 0x5a
jg greater
add r10, 0x1
call rax
mov byte ptr[rbx], al

greater:
mov rdi, rbx
add rdi, 0x1
jmp loop

skip:
mov rax, r10
ret
```

This challenge required implementing a `str_lower` function that converts a string in memory to lowercase, using a helper function `foo` located at `0x403000`. The function received the string's memory address in `rdi` and was expected to return the number of converted characters in `rax`, adhering to the System V AMD64 calling convention. 

The implementation first checked for a null `src_addr`, returning 0 if found. It then iterated through the string, character by character, using `rbx` as a temporary address holder. Inside the loop, the current character was loaded into `dl`, and a null terminator check was performed. If the character's ASCII value was less than or equal to `0x5a` (the ASCII value of 'Z'), indicating a potential uppercase character or already lowercase character, a counter (`r10`) was incremented, and the helper function `foo` was called to perform the conversion. The converted character (from `al`) was then written back to the string in memory. 

Finally, the source address (`rdi`) was incremented to process the next character. Once the null terminator was reached, the function jumped to the `skip` label, moved the conversion count from `r10` to `rax`, and returned.
## 30 most-common-byte
In this challenge we are tasked to implement the following:
```plaintext
most_common_byte(src_addr, size):
  i = 0
  while i <= size-1:
    curr_byte = [src_addr + i]
    [stack_base - curr_byte] += 1
    i += 1

  b = 0
  max_freq = 0
  max_freq_byte = 0
  while b <= 0xff:
    if [stack_base - b] > max_freq:
      max_freq = [stack_base - b]
      max_freq_byte = b
    b += 1

  return max_freq_byte
```
**Assumptions:**
- There will never be more than 0xffff of any byte
- The size will never be longer than 0xffff
- The list will have at least one element
**Constraints:**
- You must put the "counting list" on the stack
- You must restore the stack like in a normal function
- You cannot modify the data at `src_addr`
```nasm
.intel_syntax noprefix

most_common:
mo rbp, rsp
sub rsp, 0x100
xor r10,r10

loop1:
cmp r10, rsi
jg assign_freq
mov dl, byte ptr [rdi+r10]
add byte ptr[rsp+rdx], 1
inc r10
jmp loop1

assign_freq:
xor rbx, rbx
xor rcx, rcx
xor rax, rax
jmp loop2

loop2:
cmp rbx, 0xff
jg return
cmp [rsp+rbx], cl
jg update
jmp increment

update:
mov cl, [rsp+rbx]
mov rax, rbx
jmp increment

increment:
inc rbx
jmp loop2

return:
mov rsp, rbp
ret
```
This challenge required implementing a `most_common_byte` function that determines the most frequent byte within a given memory region. The function takes the starting address of the region (`src_addr` in `rdi`) and its size (`size` in `rsi`) as input and returns the most frequent byte in `rax`. The core logic involves counting the occurrences of each byte value (0-255) and then finding the byte with the highest count. The implementation uses the stack for storing the counts, adhering to standard function calling conventions.

The assembly code first allocates 256 bytes on the stack using `sub rsp, 0x100` to act as a frequency counter array. The first loop iterates through the input data, reading each byte into `dl` and incrementing the corresponding counter on the stack using `add byte ptr [rsp+rdx], 1`. The second loop iterates through all possible byte values (0-255). It compares the frequency of the current byte (at `rsp+rbx`) with the current maximum frequency (in `cl`). If the current byte's frequency is higher, the maximum frequency (`cl`) and the corresponding byte value (`rax`) are updated. Finally, the stack pointer is restored using `mov rsp, rbp`, and the most frequent byte (stored in `rax`) is returned. The key aspects of the solution are the use of the stack for frequency counting, the efficient looping through the input data and byte values, and the proper restoration of the stack before returning.