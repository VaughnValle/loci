---
tags:
  - "#comp-net"
  - "#comp-arch"
type: concept
---
- look at bit-level for error detection
- if you send $5$ and $6$
	- $11$ indicates success
	- otherwise, error
- unreliable
	- 2 inputs can result in the same checksum
	- checksum can be changed

### Internet checksum
- add 2 16-bit integers
- wraparound overflowed 17th bit and add to end
- take 1's complement (invert bit)
![[Pasted image 20240311142218.png]]