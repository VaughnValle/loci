---
tags:
  - "#comp-net"
---
- uses [[TCP]] for [[client-server]] communication
- [[HTTP request]]
- stateless
	- uses [[cookies]] to keep track of client/server states

## HTTP Versions
- 1.0, non-persistent, have to open [[TCP]] connection every request
	- can only send 1 object at a time
	- 2 [[RTT]] + file tranmission time per object
		- 1 [[RTT]] for requesting connection
		- 1 [[RTT]] + file transmission for sending file
- 1.1, option to be persistent
	- can send multiple objects per connection
	- per connection
		- 1 [[RTT]] for requesting connection
		- file transmission time for sending each object
		- 1 [[RTT]] for closing connection
	- intro to [[Web cache]]-ing
	- intro to [[cookies]]
- 2.0 ^17fd0e
	- mitigates [[Head-of-line blocking]] by dividing objects into frames
	- [[Frame Interleaving]]
- 3.0
	- switched from [[TCP]] to [[UDP]],
	- quicker and still has security with [[QUIC]]
	- still has error correction but moves it to [[Application Layer]]