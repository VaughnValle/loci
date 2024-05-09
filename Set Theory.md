---
tags:
  - discrete-math
---
## Properties
Sets are equal iff they have the same elements
	- Duplicates don't matter and order doesn't matter, remember what a [[set]] is 
## Types
- Use the concept of [[subsets]] to show that 
	- $A\subseteq B$
		- Show that if $x\in A$, then $x\in B$
	- $A\subsetneq B$
		- Show that $\exists x\in A, x\notin B$
	- $A\subseteq B$ and $B \subseteq A$
		- Show that $A=B$ by definition of [[subsets]]
- Note the diff between [[Subsets]] and [[Proper Subsets]]
- [[Cardinality]] used to show # of elements in set
- [[Power Sets]]
- use [[Tuples]] to get [[Cartesian Product]]
- [[Truth Sets]]

## Operations
- union $\cup$
	- or
- intersection $\cap$
	- and
	- note that if $A\cap B = \phi$, then $A$ and $B$ are disjoint (separate)
- complement $A^c$
	- basically $\neg A$
- difference $A-B$
	- elements only in A
	- $x\in A$ and $x\notin B$

## Identities
- Identity
	- $A \cap \mathbb U = A$
	- $A \cup \phi = A$
- Domination
	- $A \cup \mathbb U = \mathbb U$
	- $B \cap \phi \phi$
- Idempotent
	- $A\cup A=A$
	- $A\cap A = A$
- Complementation
	- $(A^c)^c = A$
- Commutative
	- $A\cup B = B\cup A$
- Associative
	- $A\cup (B\cup C) = (A\cup B)\cup C$
- Distributive
	- $A\cup (B\cap C) = (A \cup B)\cap (A\cup C)$
- DeMorgan's
	- $(A\cup B)^c = A^c \cap B^c$ and v.v.
- Absorption
	- $A\cup (A\cap B) = A$
	- $A\cap(A\cup B) = A$
- Complement
	- $A\cup A^c = \mathbb U$
	- $A\cap \phi = \phi$

Proofs for these identities are [here](https://www.youtube.com/watch?v=tRknuaNSlrU&list=PLl-gb0E4MII28GykmtuBXNUNoej-vY5Rz&index=26)