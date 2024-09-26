---
tags: netsec
---
### Notes

![[Pasted image 20240925202424.png]]
## Room 01
- What is a network segment?
	- Group of computers connected to the same medium
- What is a Subnet?
	- One or more network segments connected to the same router
- How are these different?
	- Network segment refers to the physical connection while subnet refers to the logical connection
- What are subnet masks?
	- Refers to the range of IP addresses that can be assigned in a subnet
	- The number in a subnet mask refers to the number of bits the broadcast address occupies
		- `/16` subnets are written as `255.255.0.0` = 65k hosts
		- `/24` subnets are written as `255.255.255.0`= 250 hosts
- Do you remember the basic OSI Model Layers?
	- Application - HTTP
	- Transport - TCP/UDP
	- Network - IP
	- Link - Ethernet, ARP, MAC
	- Physical
- How do you know which hosts are up and running?
	- Nmap, has 3 main approcahes
		- If user is `sudoer`, nmap uses [[ARP]]
		- If user is `sudoer` but scans external, nmap uses ICMP
		- else, nmap uses TCP via ports 80 and 443
	- Keep in mind that ARP only works if target systems are on the same subnet
		- In the same layer (link), Ethernet and WiFi needs MAC addr to communicate with any system
		- We know that a host is up if we receive an ARP reply from the ARP request
	- We can also use TCP to ping using the 3-way handshake mechanism
		- TCP SYN Ping
			- If we receive an SYN/ACK after a SYN, port is open
			- If we received an RST, port is closed
		- TCP ACK Ping
			- Similar but requires privilege
![[Pasted image 20240925201723.png]]