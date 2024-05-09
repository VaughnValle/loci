![[Pasted image 20240509001454.png]]
- a type of cache that can store multiple blocks per row
	- note that a [[Direct-mapped Cache]] is really just a 1-Way Set Associative Cache
	- A fully associative, or $\infty$ way Set Associative Cache would have all blocks in 1 row, then use associativity to refer to specific blocks
- Cache size = $rows\cdot assoc \cdot blocksize$
- [[AMAT]]
- How do we do this? through [[Associative Cache#Eviction Policies]]
- Adv? 
	- No thrashing blocks where we evict what we need right after
- Disadv? 
	- Expensive, cmp operation done through tag for each block in 1 row
	- Slow
### Eviction Policies
- "replacement algorithms" for a better term
Types
- [[FIFO]]
	- evict block that has been there the longest
	- but suboptimal, think about essential things that are loaded first, but are always needed in cache?
		- OS routines
	- data loaded first don't always have to be thrown out first
- [[LRU]]
	- evict the most stale block
- [[RR]]
	- yolo, just randomly choose which block to evict
- [[NMRU]]
	- yolo, choose at random as long as it's not the [[MRU]]

### Write Policies
For hits
- write-through
	- writes go to [[CPU Cache]] AND [[RAM]]
	- ![[Pasted image 20240509010533.png]]
- write-back
	- writes only go to [[CPU Cache]]
	- then mark block being written to as dirty
		- when this "dirty block" is evicted, its data is written to RAM
	- ![[Pasted image 20240509010558.png]]
For misses
- write-around
	- write to [[RAM]] directly
	- bypass [[CPU Cache]]
	- ![[Pasted image 20240509010618.png]]
- write-allocate
	- write to cache + either write-back or write through

> [!info] Resources
>- [ Fully Associative Caches and Replacement Algorithms](https://www.youtube.com/watch?v=A0vR-ks3hsQ)

