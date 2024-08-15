---
tags:
  - comp-net
type: concept
---
- inverse of [[Multiplexing]]
	- extracting individual signal from one stream where these were previous combined via [[Multiplexing]]
- use __header info__ to deliver segments to correct socket
	- utilize port to send to correct socket
- different based on [[Transport Layer]] protocol
- host receives IP [[datagram]]
	- each [[datagram]] has as source and destination IP
		- each carries one [[segment]]
			- each [[segment]] has source and destination port
- happens in receiver

Connectionless ([[UDP]]) vs Connection-oriented ([[TCP]]) [[Demultiplexing]]:

[[UDP]]
1. 2-tuple
2. Only need dest [[IP]] and dest [[port]]
3. datagrams with same dest port will be directed to same socket at receiving host
	1. even if they have different source [[IP]] or [[port]]
[[TCP]]
1. 4-tuple
2. Needs source [[IP]], source [[port]], dest [[IP]] , dest [[port]]
3. datagrams will be directed to different sockets at receiving host
	1. This allows us to open and support multiple [[TCP]] sockets
	2. Web servers have different sockets for each connecting client