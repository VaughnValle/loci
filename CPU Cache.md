---
tags:
  - "#comp-arch"
---
Why do we need cache in processors?

Recall that there are two types of memory used in a computer, [[DRAM]] and [[SRAM]]. Also recall that [[DIMM]] modules use [[DRAM]], the slower type of memory. Because of specific processor operations, [[DRAM]] is too slow for certain use cases. 

The [[CPU Cache]] provides a faster buffer interface/bridge between the [[CPU]] and [[RAM]]
- recall that [[SRAM]] is faster than [[DRAM]] albeit being substantially more expensive
	- If we can store important data in cache, we don't need to fetch from slower [[RAM]]
	
- Because of its speed, [[CPU Cache]] uses [[SRAM]]

The whole point of a [[CPU Cache]] is to minimize our access to the slower [[RAM]] and increase our effective speed for data access.
## Components
What makes up a cache? Rows and blocks

First, we make a cache with $n$ rows. Then, we group memory cells into "blocks" to store in the rows of our cache

There are 5 main components of a cache.
- numrows
	- describes how many rows our cache will have
- blocksize
	- denotes how large the blocks of consecutive data that we need to store
- blockid
	- address // blocksize
- row
	- blockid % numrows
- tag
	- blockid // numrows
## Caching Process
- check tag
	- if match, Hit
	- if not
		- if nothing there, Miss: populate
		- if something there, Miss: evict and populate
## Types
L1, L2, and L3? Why do [[CPU]]s need more than one cache?
1. Level 1 Cache (L1)
	2. same speed as the [[CPU]]
2. Level 2 Cache (L2)
	2. used to catch data accesses missed by L1
3. Level 3 Cache (L3)
	1. shared cache, shared by all cores in CPU
	2. used to catch data access missed by L2
5. if miss, go back to [[RAM]]!
## Implementations
- [[Direct-mapped Cache]]
- [[Associative Cache]]
- [[Multi-level Cache]]

