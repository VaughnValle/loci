- when memory can no longer be accessed, it should be taken away

## Reference Counters
- Keep track of count of pointers pointing to the memory address
- If zero, reclaim
## Mark-Sweep
- Walk through *ALL* pointers in the entire program and analyze
- reclamation occurs when list of variable space becomes empty
- Stuff you can't gain access through is gone
- CAVEAT
	- cannot change anything
	- program must HALT when garbage collection runs