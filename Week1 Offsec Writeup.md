---
tags:
  - offsec
---
by Vaughn Matthew Q. Valle

# Preface
None, didn't have enough time to write one.


## Directions
In this challenge we are given the address of `main()` in raw bytes.  Using `file` we can see that given binary is a [[PIE]]
![[Pasted image 20240917151544.png]]
![[Pasted image 20240917180627.png]]
Using the ff. memory addresses shown in [Binja](https://binary.ninja/), offset from whatever raw bytes we get from the program would be `hex(raw) - 0x1223 + 0x1209`. Sending the result memory address in raw bytes gives us the flag
## GDB 0
![[Pasted image 20240917182559.png]]
This challenge is the first introduction to GDB, also known as the Gnu DeBugger. After the prompt disappears, a binary executes asking us for a password. 
![[Pasted image 20240917182510.png]]

If the secret password is being compared against a local string variable, then we can view the lines gdb is going to execute using `list`
![[Pasted image 20240917182414.png]]
Here we see a `char` array as the password the program is looking for. Inputting this gives us the flag.
## GDB 1
Another GDB challenge. First thing I do is execute the program and analyze behavior.
![[Pasted image 20240917221252.png]]
Using the hint, I disassemble the main function to see which address is being set to 0
![[Pasted image 20240917221056.png]]
We see a `memset` call at `*main+51`. We can set a breakpoint via
```bash
break *main+51
```
Running the program via `run` stops execution at the break point we just set. Interestingly, we see an address being set to 0
![[Pasted image 20240917221538.png]]
Giving this as input and hitting `n` to continue exection until `get_flag()` is called gives us the flag.
## Basic Math
![[Pasted image 20240917181158.png]]
Calculate offset and get to the the `+` operation that is on `0x00001285`
## GDB 2
This is another GDB challenge. First by disassembling main we can see pretty much standard stuff aside from a function called `read_file`
![[Pasted image 20240917211704.png]]

Disassembling this function reveals a value loaded into rcx
![[Pasted image 20240917211846.png]]
Printing the string stored in this `<flag>` variable reveals the flag 