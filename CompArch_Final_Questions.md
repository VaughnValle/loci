Questions:

### Will there be implementing E15 Turbo?

### E20 Control Signals Questions
#### When do MUX vals matter?
![[Pasted image 20250505141749.png]]
#### Why is sw FuncALU add and not DC?
![[Pasted image 20250505141603.png]]
#### Why do we need sign-extend and why for jeq again? 
To make it compatible with 16 bit addresses
#### How to do jr and lw control signals


#### Cache
```e20

3rd block evicts 
lw $1 , 20( $0 ) # cache block 10 in row 2

lw $1 , 28( $0 ) # cache block 14 in row 2

lw $1 , 36( $0 ) # cache block 18 in row 2 , and evict block 10

halt

miss on l1 hit on l2
# on L1 : miss , block 10 , row 2

# on L2 : miss , block 5 , row 1

lw $1 , 20( $0 )

# on L1 : miss , block 11 , row 3

# on L2 : hit , block 5 , row 1

lw $1 , 22( $0 )

halt
```

