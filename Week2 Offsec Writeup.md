---
tags:
  - offsec
---
## Quasar
In `main`, we see that our input is being compared to `0x3f5476a00`
![[Pasted image 20240924181126.png]]
By inputting this address, we bypass the if and get the flag
## Secrets
## StrS
In `main`, we can see that to get the flag, we need to bypass the if statement by reading the correct input into `var1` such that it is equal to `var2` ![[Pasted image 20240924182219.png]]
Analyzing `var2`, we see relevant info in the `init()` function
![[Pasted image 20240924182336.png]]
We see that ` SMSS J052915.80` is being copied over to `var2` while `2.0` is being copied over to a mysterious `data_40b8`. These variables seem mysterious so let's look at it via GDB. Disassembling the main function we see the `strcmp`. 
![[Pasted image 20240924182930.png]] 
I want to set the breakpoint before that so we can see the value of `var2` so we know what to input
![[Pasted image 20240924182940.png]]
When run, we get this
![[Pasted image 20240924183016.png]]
We see that `var2` is located at memory address `0x5555555580a0`, printing the value in it in GDB via `x /s 0x5555555580a0`
![[Pasted image 20240924183112.png]]
Inputting this gives us the flag

## Cosmic Distance
Analyzing the binary in Binja, we see that our input must be equal to the value of a variable called `distance`
![[Pasted image 20240924183506.png]]
Clicking on distance shows us that the value to be equalled to should be `0x2cb417800`
![[Pasted image 20240924183535.png]]
Inputting this gives us the flag

## Favorite
In Binja, the `main` function shows that user input is being compared to the memory address `0xc01dc0ffee`.
![[Pasted image 20240924184802.png]]
But notice the aforementioned address is being compared to `**read_input()`.

This means that whatever our input would be dereferenced twice, which means that 
> the address we need to input should contain an address of a pointer pointing to variable containing `0xc01dc0ffee`

Going back to `main`, we see an interesting function called `init()`. Looking at this function in Binja shows
![[Pasted image 20240924185512.png]]
We see that `data_43f8` has what we're looking for. Since we're given the raw byte address of `hint()`, then adding the address to the offset of this variable from hint, which is `0x314f` from analyzing addresses in GDB, gives us the flag.
## Numbers
This challenge was surprisingly trivial. Analyzing `main`, we see
![[Pasted image 20240924191202.png]]
We also see that the `infinity()` function represents the game being over as shown
![[Pasted image 20240924191230.png]]
Thus, all we need is to prevent `infinity()` from executing by making sure each question returns a non-zero value. 

Each question is structured similarly. They always start by calling `input_answer()` asking for an address and a "size to dereference". In each question, there's always a variable comparison between a `data` variable against a `var` as shown below.
![[Pasted image 20240924192040.png]]
Analyzing `input_answer()` in Binja shows this
![[Pasted image 20240924191832.png]]
And `get_address()` likewise.
![[Pasted image 20240924191914.png]]

The objective is first, to provide the correct address of `data` such that when we check the correct string input from `input_answer()`, we satisfy `return (data == var)`. Doing that for each question leads us to the flag