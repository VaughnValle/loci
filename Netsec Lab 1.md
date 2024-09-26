---
tags: netsec
---
### Notes
## Room 01 - Intro to Subnets and Nmap
![[Pasted image 20240925202424.png]]
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

## Room 02 - Nmap basic port scans
![[Pasted image 20240926150826.png]]
- What are ports used for?
	- Much like how IP addresses are used to identify hosts on a network, ports are used to identify a specific a network service running on a host
	- A port is exclusive for that service: only one service can listen on a TCP/UDP port
		- Open port: there exists a service listening on that port
		- Closed port: no service is listening on that port
- Nmap considers six port states when scanning for services that are up
	- Open
	- Closed
	- Filtered
		- port inaccessible, cannot be determined if open/closed
		- Usually when firewall is preventing [nmap] from reaching that port), preventing [nmap] from determining if port is open or closed
	- Unfiltered
		- port accessible, cannot be determined if open/closed
		- usually happens when doing an ACK scan with `-sA`
	- Open/Filtered
		- cannot determine whether port is open or filtered
	- Closed/Filtered
		- cannot determine whether port is closed or filtered
- Recall the format of a TCP Header specified in [[RFC793]]
	- First 24 bits of a TCP segment
	- [[TCP Header Flags]]
- Recall that a TCP 3-way Handshake process occurs as follows
	- ![[Pasted image 20240926144100.png]]
- TCP is important because it is the only way to scan with an unprivileged user
	- An open port will respond to `SYN` with `SYN/ACK` 
	- A closed port will respond to `SYN` with  `RST/ACK`
	- Note that we are not establishing connection, but merely scanning ports. Thus after the ACK we close connection with `RST/ACK`
	- ![[Pasted image 20240926144201.png]]
- Recall that UDP is connectionless, hence it does not require handshake
	- Because of this, sending a UDP packet to a closed port will not get us a response
	- However, UDP packets return ICMP port codes, if the port is closed, we get ICMP type 3
- Nmap by default scanns the default 1000 most common ports, however you can specify options:
	- port list: `-p22,80,443`
	- port range: `-p100-200` (inclusive)
	- ![[Pasted image 20240926150810.png]]
## Room 03
![[Pasted image 20240926163914.png]]
### Firewall

A firewall is a piece of software or hardware that permits packets to pass through or blocks them. It functions based on firewall rules, summarized as blocking all traffic with exceptions or allowing all traffic with exceptions. For instance, you might block all traffic to your server except those coming to your web server. A traditional firewall inspects, at least, the IP header and the transport layer header. A more sophisticated firewall would also try to examine the data carried by the transport layer.

### IDS

An intrusion detection system (IDS) inspects network packets for select behavioural patterns or specific content signatures. It raises an alert whenever a malicious rule is met. In addition to the IP header and transport layer header, an IDS would inspect the data contents in the transport layer and check if it matches any malicious patterns. How can you make it less likely for a traditional firewall/IDS to detect your Nmap activity? It is not easy to answer this; however, depending on the type of firewall/IDS, you might benefit from dividing the packet into smaller packets.

### Fragmenting Packets!

### Idle/Zombie Scans


![[Pasted image 20240926163852.png]]

## Room 04