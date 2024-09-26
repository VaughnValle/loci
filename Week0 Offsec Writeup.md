---
tags:
    - offsec
author:
---

# Preface

Despite being an [OSIRIS](https://osiris.cyber.nyu.edu/) member, I never felt like I had what it takes to be a CTF player. There's always this doubt at the back of my mind, that a challenge will come that will have me banging my head against a wall for a week straight without any progress. While I've always embraced challenge, my confidence coming into this class is incredibly low, despite having solved numerous CTFs challenges. I have not taken Operating Systems nor Application Security. I do not have the formal education and background to understand the concepts to be tackled in this course.

However, I guess I can say to myself that I have contributed to [CTF101](https://ctf101.org/) in little ways. I can say that I have self-studied and am willing to work hard to create this foundation myself. I hope the green flag submissions from this course will slingshot me into confidence.

## Are You Alive

This intro challenge just seems to be a sanity check to verify netcat is able to connect to the remote server.

```bash
nc offsec-chalbroker.osiris.cyber.nyu.edu 1237

```

Running the above results in the flag

## Baby glibc
In this challenge, we are given 

## Vault 0

When connecting via the netcat command, the program prompts for the base 10 address of a `secret vault`.

![[Pasted image 20240909105417.png]]
Analysis in [Binja](https://binary.ninja/) shows that to get the flag, we must bypass the if conditional statement by inputting into `rax_3` the memory address of `secret_vault`.

Searching for `secret_vault` shows that it is located in `0x00401236` as seen here
![[Pasted image 20240909123219.png]]

Inputting the hex memory address shows that the program only accepts base 10 input. The hex code `0x401236` is `4198966` in decimal representation, which when inputted gives us the flag.

## Vault 1

This challenge is similar to [[Week0 Offsec Writeup#Vault 0]] with the only difference being that [PIE](https://ir0nstone.gitbook.io/notes/binexp/stack/pie) is enabled. We are already given in standard output the base address of the executable.
![[Pasted image 20240910095910.png]]
As seen above, `secret_vault` is offset from the base address by `0x00001249`. Adding that offset to the arbitrary base address gives us the flag

## Vault 2

Building upon [PIE](https://ir0nstone.gitbook.io/notes/binexp/stack/pie), this challenge leaks a variable `fake_vault`'s address instead of the base address. Since the internal offset between addresses in an executable are constant, knowing the internal address of `fake_vault` is enough to get `secret_vault`'s address.
![[Pasted image 20240910100351.png]]
Since `fake_vault` is at `0x00004029`, base address can be calculating by subtracting it with the aforementioned address then added to `secret_vault`'s address which is `0x00001249`: of which we get the flag

## Vault 3

Similar to the previous challenges however the base address is outputted in raw bytes.
![[Pasted image 20240910164916.png]]
Using [Pwntools](https://docs.pwntools.com/en/stable/), we can easily convert from raw bytes to hex using `hex(bytes)`, and then add the `secret_vault`'s address to the converted hex addres.
![[Pasted image 20240910165011.png]]
Inputting the memory address in the variable `address` gives us the flag

## Glibc

![[Pasted image 20240910175040.png]]

## Vault 4

![[Pasted image 20240910175027.png]]
