---
tags:
  - "#comp-net"
---
- don't send the object if cache has latest version
	- if not modified: ```304 Not Modified``` code, only sends out header
	- else: update cache, ```200 OK``` code, send the HTML object
	- detects if up-to-date with ```last modified date```