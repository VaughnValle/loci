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
	- 
- [[RDT]], reliable data transfer protocol