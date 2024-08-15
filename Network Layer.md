---
tags:
  - "#comp-net"
---

- IP
	- v4: 32bits
	- v6: 128bits
	- header usually points to [[TCP]] header
	- tunneling
		- receives an IPv6 packet, creates a new IPv4 packet, and stores the IPv6 as payload
		- carrying an IPV6 packet inside an IPV4
		- if there is a router in the chain that only supports ipv4
			- the dest gets modified to the next router that supports IPv6
				- once the IPv6 packet reaches IPv6 router, it unpacks it
		- tunneling doesn't work the other way
	- fragmentation
		- [[Link Layer]] links has MTU
			- datagrams get converted into smaller ones
		- length, ID, fragflag, offset
			- offset used to reassemble fragmented packets
			- divide payload by 8
				- why 8? length field can be up to 16 bits but offset only 8-bits
- [[NAT]]
- How does [[DHCP]] work?
- [[MTU]]
- Router does [[Destination based Forwarding]] via [[IP]]
- [[Middleboxes]]	

[[Data Plane]] ^6dcdaf
- forwarding
- router-router

[[Control Plane]] ^ff0b00
- routing
	- [[link state]]
	- [[distance vector algorithms]]
- source-destination
[[autonomous system]]