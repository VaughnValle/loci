---
tags:
  - comp-net
type:
---
## Definition
- Transmission Control Protocol
- Established via a 3-way handshake

### Features
- reliable
- in-order delivery
- congestion control


> [! important] TCP uses Connection-oriented [[Demultiplexing]]
> - Uses [[TCP#Quad-tuple model]]
### Quad-tuple model
Essential to have, in any order:
- source IP
- source port
- dest IP
- dest port
to direct segment to correct socket

- source ports are not shared in TCP
	- new [[TCP#Quad-tuple model]] are created for each socket
	- server creates new socket per datagram
