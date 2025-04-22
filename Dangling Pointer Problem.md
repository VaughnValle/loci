
## Tombstone
- allocate extra heap cell pointing to the heap-dynamic variable
- if deallocation occurs, we set it tombstone to nil
- costly in time and space

## Locks and key
- the key is the cell to the pointer of the lock