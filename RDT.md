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
	3. FSM
		1. waiting for call above, then send rdt_send, create_pkt, udt_send
2. 2.0
	1. underlying channel may flip bits
	2. [[checksum]] for bit errors
	3. acknowledgement to check if message understood
		1. [[ACK]], pkt received OK
		2. [[NAK]], pkt had errors
			1. retransmit on this
	4. one at a time, stop and wait timing
	5. data can never be lost, only corrupted
	6. FSM
		1. sender
			1. wait for call above, then wait for [[ACK]] or [[NAK]]
			2. udt_rcv(rcvpkt)
			3. is[[NAK]]
				1. udt_send(sndpkt)
			4. is[[ACK]]
				1. udt_rcv(rcvpkt)
		2. receiver
			1. wait for call from below, then check if corrupt
			2. udt_rcv(rcvpkt)
			3. if corrupt, udt_send([[NAK]])
			4. else,
				1. extract
				2. deliver_data
				3. udt_send([[ACK]])
	7. Problem: what if [[NAK]] and [[ACK]] is corrupted?
		1. then if sender doesn't know how to interpret response, it will send it again & again, to retransmit, which will make duplicates
		2. Solution: [[sequence numbers]]
			1. account for duplicates
			2. keep sender & receiver in sync
			3. sync tool to 
3. 2.1
	1. [[sequence numbers]]
	2. now we have double the states
		1. sender has 4 states
		2. receiver has 2 states
	3. now we check:
		1. sender: ACK OR NAK, and attach seq_number to segment
			1. seq_number included in checksum
		2. receiver: if corrupt, and if seq_num match
4. 2.2
	1. [[NAK]]-free protocol
		1. use [[ACK]] and [[sequence numbers]] to detect success
		2. we don't need [[NAK]] bec if [[sequence numbers]] is unexpected, expect retransmission of lost pkt
5. 3.0
	1. Problem: packets can be lost
	2. Solution: timer
		1. if we don't get [[ACK]] back in time, we retransmit with udt_send