---
tags:
  - offsec
---
## What is OffSec?
### Skills
- How can I make this crash?
- Understanding source code
	- How do I influence program to do something unexpected or weird?
- Rev Eng
- Static and dynamic analysis
- Exploitation

### Writeups
1. [[Week0 Offsec Writeup]]
2. [[Week1 Offsec Writeup]]
3. [[Week2 Offsec Writeup]]
4. [[Week3 Offsec Writeup]]
5. [[Week 5 Offsec Writeup]]
6. [[Week6 Offsec Writeup]]
### Notes
- Array doesn't look for endianness
- Humans read in big endian, computers in little endian
- A pointer is just an address
- Week 8 does not have Safe Link
- Safe-linking alg encrypts via XOR, Week9
	- `p/x (addr >> 12) ^ next_addr`
		- encryption
	- poisoning t cache
		- need to do what glibc would have done, replicate what should have been done
		- `p/x (addr >> 12) ^ garbled`
			- decryption
- `_environ` lives on GLIBC
	- usually ends on an 8
- Learn about Binja structures and field shortcuts
- `malloc` always returns an address
	- Always check field sizes if they match with the `buf` sizes in each `fgets` to determine if buffer overflow is possible