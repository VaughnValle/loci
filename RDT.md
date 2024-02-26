---
tags:
  - comp-net
---
- not a real protocol

## Interfaces
1. rdt_send
	1. sender-side implementation of [[RDT]]
	2. called from [[Application Layer]] to [[Transport Layer]]
3. udt_send
	1. called from [[Transport Layer]] to [[Network Layer]]
4. udt_rcv
	1. called from  [[Network Layer]] to [[Transport Layer]]
5. deliver_data
	1. receiver-side implementation of [[RDT]]
	2. called from [[Transport Layer]] to [[Application Layer]]

use [[FSM]] to specify sender, receiver

versions
1. 1.0
	1. underlying channel perfectly reliable
	2. no bit errors and packet loss
2. 