---
tags:
  - "#comp-net"
---
- Dynamic Adaptive Streaming over HTTP
- divide video file into multiple chunks
	- chunk encoded at different bit rates
	- [[manifest file]] provides URL for different chunks
	- server keeps track of the location of multiple chunks
- the process of re-evaluating the network performance and deciding which quality (bitrate or encoding rate) to play
	- adjusting bitrate based on network performance


### Related
- [[CDN]]