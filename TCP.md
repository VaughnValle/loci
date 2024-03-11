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
### Segment Structure

1. 20 bytes or more of data
2. sequence number and [[ACK]]s corresponds to byte number 
### Flow Control
- one sender is too fast for one receiver
- pressure too strong for dog
1. rwnd and RcvBuffer
2. first RFC used [[Go-Back-N]] [[ARQ]]
3. modern implementation uses [[Selective Repeat]]

### Handshake
- [[ESTAB]] stands for connection established
### 2-Way
LISTEN -> ESTAB
1. what happens when client retransmit request for connection even after server accepts initial request?
	1. we get a hanging connection from a server

### 3-WAY
LISTEN -> SYNRCVD -> ESTAB
Opening:
1. Client sends [[SYN]], synchronization packet
3. Server responds with [[SYN]] and [[ACK]]
4. Client sends [[ACK]]
5. ESTAB
Graceful Closing:
1. Closer sends [[FIN]]
2. Receiver sends [[FIN]] [[ACK]]
3. CLOSED
Non Graceful Closing:
1. Closer sends [[RST]]
2. CLOSED
Note that we don't care if we get response once closer sends [[RST]]

- relative [[sequence numbers]] start at 0, more readability but in actuality it starts at a random number
- if TCP Packet [[SYN]] is @ 81 if you send 10 bytes worth of data, response [[ACK]] number will be 91
- in the case of a phantom byte, where there is no data, [[ACK]] will be next sequence number


### Congestion Control
- too many senders or sending too fast
- too many cars on the road
- manifests in
	- long delays
	- packet loss
- a top-10 problem
- this is a REALLY BIG problem
	- as you approach link rate such as $R/2$, then packet tranmission approaches $0$
#### Approaches
1. [[End-end congestion control]]
	1. inferred
	2. look at observed loss
	3. TCP backs off
2. [[Network-assisted control]]
	1. router provides feedback
	2. feedback indicates congestion level or sending rate
	3. TCP ECN, ATM, DECbit protocols


### How does TCP handle congestion?
- extremely cautious
1. [[AIMD]]
- Loss can be indicated when [[ACK]] is stuck on a number, which means server never got the packet at that sequence number, so packet at that sequence number needs to be retransmitted to move on