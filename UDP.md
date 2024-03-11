---
tags:
  - "#comp-net"
---
### Definition
- User Datagram Protocol
- minimal, just send message
- barebones
- [[RFC 768]]

### Features
- unreliable and unordered
	- [[UDP]] segments may be lost or out-of-order
- best-effort IP

> [! important] [[UDP]] utilizes connectionless [[Demultiplexing]]
> - only need destination port to send to correct socket

### Connectionless Transport
- no handshaking between sender and receiver
Why do we use [[UDP]]?
1. No connection establishment
	1. minimize [[RTT]] delay
2. Simple
	1. no connection state
3. small header size
4. no congestion control
	1. can be desirable for max speed

### [[UDP]] uses
1. streaming
2. [[DNS]]
3. [[SNMP]]
4. [[HTTP^3.0]]


### Process
1. passed an app message
2. determine header values
3. create segment
4. pass segment to [[Network Layer#IP]]

### Segment header
1. source port
2. dest port
3. length
4. [[checksum]]
### Segment body
1. payload