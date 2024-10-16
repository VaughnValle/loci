---
tags:
  - comp-net
---
- allows logical communication between processes
- break application layer messages into segments, send to [[Network Layer]]

### Main Components
1. [[Multiplexing]] and [[Demultiplexing]]
2. [[Principles of Reliable Data Transfer]]
3. [[ARQ]]
4. [[UDP]]
5. [[TCP]]
6. [[QUIC]]

### Process
1. Sender
	1. passed an application-layer message
	2. determine segment header values
	3. create [[segment]]
	4. send [[segment]]
2. Receiver
	1. Receive segment from [[Network Layer]]: IP [[datagram]]
	2. check header values
	3. extract app-layer message
	4. pass message up to application via socket, [[Demultiplexing]]