---
tags:
  - offsec
---
by Vaughn Matthew Q. Valle

## Writeups
### Rewards
WIP
### Knapsack
As with all challenges, the first thing I do is run the program and analyze runtime behavior. In this case, the program gives us an input prompt.
![[Pasted image 20241001122042.png]]
Opening the binary in Binja (after some manual cleanup and conversion) shows us that the program expects a total of 6 variables
![[Pasted image 20241001122656.png]]
These 6 variables are fed through a `process()` function that does the ff.
![[Pasted image 20241001193617.png]]
Note that the function also multiplies each argument passed to a set of variables declared here
![[Pasted image 20241001194029.png]]
Recall that in `main`, we need the following conditions met to get to `get_flag()`:
1. All six variables should be greater than 0
2. When `process(a,b,c,x,y,z)` is called, return value `!= 0`

Thus, we an use [Z3 Theorem Prover](https://ericpony.github.io/z3py-tutorial/guide-examples.htm) to calculate a set of 6 variables that will satisfy our conditions
![[Pasted image 20241001194141.png]]Running this gives us a set of 6 variables, that when inputted, gives the flag
### Disks Game
Running the executable gives us an input prompt asking for how many disks we want start with.
![[Pasted image 20241001194947.png]]
When inputting 1, the program jumps to an exit/error statement
![[Pasted image 20241001195032.png]]
Interestingly however, the behavior is different with large numbers. A mere change to `50` makes the program take significantly longer to spit out an output.
![[Pasted image 20241001195146.png]]
Also interesting is that values above `100` get treated as two-digits and submitted as input, while the third digit gets inputted in the terminal in then next stream.
![[Pasted image 20241001195251.png]]
I think it's important to keep this behavior in mind in program analysis later. Now we can dive into `main()` in Binja
![[Pasted image 20241001195438.png]]
Two things strike my interest: `initialize()` and `process()` of which are input is passed into. Because of the if conditional, the return value of `process()` must be __nonzero__

Let's reverse engineer both functions:
![[Pasted image 20241001195801.png]]
![[Pasted image 20241001195813.png]]
Things to note here to get the flag: ^7e5ab3
1. `goal` variable is set to `0x7fffffff` or  $2147483647$ in decimal
	1. We can also see this in [gdb](https://www.sourceware.org/gdb/)
		- ![[Pasted image 20241001201057.png]]
1. `arg1` should be greater than `0`
2. `process()` calls a function called `recurse()`
3. `total_moves == goal`, which tells us that ideally `total_moves = 2147483647` 

Satisfying these conditions will result in us getting the flag. With that in mind, let's look at what `recurse()` does
![[Pasted image 20241001200152.png]]
From above, we can see that with each call, `recurse()` recurses twice; first with `arg1-1, arg2, arg4, arg3` as parameters and second with `arg1-1, arg4, arg3, arg2`. Also note that with each call, `total_moves` is incremented by 1. ^8b4feb

Hence, this tells us that the value of `total_moves` with respect to $n$ calls of `recurse()` is defined as $2^n$. This is because the function calls itself twice with each call.

Recall [[Week3 Offsec Writeup#^8b4feb]], and note that conveniently, $2147483647 = 2^{31}$. Thus, if we input $31$, we satisfy all conditions in [[Week3 Offsec Writeup#^7e5ab3]] and get the flag
### Flips
WIP