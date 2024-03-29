---
tags:
  - "#comp-net"
---
- sender can send multiple frames before getting [[ACK]] for first frame
- sliding window to send packets sequentially
	- using [[sequence numbers]] and window size
- retransmit all packets in current window if [[ACK]] for a frame not received in time

![[Pasted image 20240311144619.png]]