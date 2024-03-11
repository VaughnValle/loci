---
tags:
  - "#comp-net"
---

- also known as DomainKey Identified Mail
- works by adding a digital signature to messages to verify authenticity of mails
- attached to message header
	- domain `d=`
	- selector `s=`
	- encryption alg `a=`
- public key then obtained from sender's domain and cross-referenced to validate