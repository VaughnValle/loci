---
tags:
  - discrete-math
---
## Definition
For all $\mathbb Z$, $a$ and $b$, if $a,b>0$, and $a\mid b$, then $a \leq b$

Proof:
1. Suppose $a$ and $b$ are any particular but arbitrarily chosen $\mathbb Z$, such that $a,b>0$ or $a,b\epsilon \mathbb {Z^+}$ and $a\mid b$
2. Then by definition of [[Divisibility]], $\exists k\epsilon \mathbb Z$ such that $b=ak$
3. $\frac b k = a$
	1. Suppose that $k\epsilon \mathbb {Z^+}$
	2. if $k=1$, $a=b$
	3. else, $a=\frac b k$, then $a < b$
	4. $\therefore$ $a \leq b$