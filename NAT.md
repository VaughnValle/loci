- Network Address Translation
- delay the exhaustion of IPV4 addresses by 
	- making all devices in the local network share a single IPV4 address to the whole external internet
	- does this using a translation table 
- [[NAT]] modifies packets
	- takes in packet, changes SRC IP and PORT to perform reverse lookup and forward it to a specific device in the local network
- NAT intrudes on [[Transport Layer]] by modifying IPs and ports


### Steps
1. Modify SRC [[IP]] & [[port]]
2. Put mapping in NAT Table
3. [[Reverse Lookup]] NAT Table