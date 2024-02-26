---
tags:
  - discrete-math
---
## Steps
1. Write down the statement to be proved
2. Write "Proof: "
3. Make it self contained
	1. Should be clear, everything should be explained
4. Use correct grammar & complete sentences
	1. Read it out loud and it should make sense
5. Provide reasons for your work
6. Display your math
	1. Write down equations
	2. Do `x^2 = 1`, not `x squared is equal to one`


## Examples
#### The difference of any odd integer and even integer is odd.
Proof: 
1. Suppose $m$ and $n$ are any two integers 
	1. such that $m$ is odd and $n$ is even
2. By definition of even and odd integers, $m=2k+1$ and $n=2r$ 
	1. where $k,r\epsilon \mathbb Z$
3. Now, $m-n=2k+1-2r$ by substitution
4. $m-n=2k-2r+1$ by [[Commutative Property]]
5. $m-n=2(k-r)+1$ by [[Distributive Property]]
6. where $(k-r)\epsilon \mathbb Z$ because integers are closed under addition/subtraction
	1. set is closed, perform operation of elements in the set and you get a result that's also just inside that set
7. let $k-r=b$, $b\epsilon Z$
8. By substitution, $m-n=2b+1$
9. Then by [[definition of odd and even integers]], $m-n$ is odd
	1. from $2b+1$, which is odd
10. $\therefore$ the difference of any odd and even integer is odd


### Notes
1. Can't use some, changed the quantifer to $\exists$ from $\forall$
