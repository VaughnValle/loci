---
tags:
  - discrete-math
type: concept
---
- If something holds true for all elements in a set then it also holds true for each element in that set

$$
a \cdot a=a^2
$$

Another example,
1. All math teachers are old
2. Joe is a math teacher
3. $\therefore$ Joe is old

## Universal [[Modus Ponens]]
Recall [[Modus Ponens]], now suppose we have
1. $\forall x$, if $P(x)$ then $Q(x)$
2. $P(a)$ for a particular $a$
3. $\therefore$ Q(a) 

This is Universal [[Modus Ponens]]

Example, 
1. if an integers is even, then its square is also even
2. $k$ is a particular integer that is even
3. $\therefore k^2$ is also even 

Can also be expressed as:
1. $\forall a \epsilon \mathbb Z$, if $a \epsilon 2\mathbb Z$, where $2\mathbb Z$ represents even integers, then  $a^2\epsilon \mathbb Z$
2. $k\epsilon 2\mathbb Z$
3. $\therefore k^2\epsilon 2\mathbb Z$

## Universal [[Modus Tollens]]
Recall [[Modus Tollens]]
1. $\forall x$, if $P(x)$ then $Q(x)$
2. $\neg Q(a)$ for a particular $a$
3. $\therefore \neg P(a)$


1. All math teachers are old: $\forall m, m(x) \implies old$
2. Joe is old: $old$
3. Joe is a math teacher: $\therefore m$, this is a [[converse error]]

Ultimately, this is the breakdown:
- We said that all math teachers are a subset of old set
- Since Joe is old, he is part of the math teacher subset
- But this is wrong, Joes can be inside old set, but outside of math subset
This is Universal [[Modus Tollens]]

For this, [[Venn Diagrams]] are useful to prove whether arguments are valid or not by analyzing the sets they are a part of. We can then construct the counterexamples to prove out argument

1. If an infinite series converges then the terms go zero
2. This infinite series does not converge
3. $\therefore$ The terms do not go to zero