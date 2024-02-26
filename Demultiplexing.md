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
- 