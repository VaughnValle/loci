---
tags:
  - comp-net
---
- also known as Domain Name System
### Functions
1. hostname $\rightarrow$ IP translation
2. [[host aliasing]]
3. [[mail server aliasing]]
4. [[load distribution]]

### Why is DNS Decentralized?
- single point of failure
- traffic volume
- distant database if centralized
- maintenance
- doesn't scale
### Types (Hierarchy)

^65f612

1. [[Root Name Servers]]
2. [[Top Level Domain]],  have different [[DNS]] servers
	1. .com, .org, .edu
3. [[Authoritative Domain]]
4. Local DNS server not part of hierarchy

### Query/Resolution Types
1. [[Iterative Query]]
2. [[Recursive Query]]

### Related
- [[DNS Records]]
- [[DNS Registrar]]