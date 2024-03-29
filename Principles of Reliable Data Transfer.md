---
tags:
  - "#comp-net"
---
What is reliable data transfer?
- when developing on the [[Application Layer]], we assume layers below are reliable
- but network can be congested, making [[Network Layer]] unreliable
- this is why we introduce reliable service implementation at the [[Transport Layer]]
	- making sure that data gets send in order
	- sender and receiver don't know about each other
	- curtain behind [[Network Layer]]
- [[RDT]], reliable data transfer protocol
- [[Go-Back-N]] vs [[Selective Repeat]]
	- [[Selective Repeat]] has buffer, retransmits only pkt2
		- buffer, rearrange, and deliver to [[Network Layer]]