---
tags:
  - discrete-math
---
## Definition
A real number is rational IFF it can be represented as a ratio of two integers, $a$ and $b$ with a nonzero denominator

$r\epsilon Q$ IFF $\exists a,b\epsilon \mathbb Z$ such that $r=\frac a b, b\ne 0$

### Example 1
2.1
1. $2.1=21/10$
2. $21\epsilon Z$ and $10\epsilon Z$ and $10\ne 0$

### Example 2
$0.\bar 9$
1. let $x=0.\bar9$
2. then $10x=9.\bar9$
3. $10x-x=9$
4. $9x=9$
5. $x=1$
$0.\overline{12}$
1. let $x=0.\overline{12}$
2. then $100x=12.\overline{12}$
3. $100x-x=12$
4. $x=12/99$
52.4672167216721
1. let $10x = 524.67216721...$
2. let $100000x=5,246,721.6721...$
	1. Multiply until the decimals match such that it gets removed during $bx-x$
3. $100000x-10x = 5,246,721-524$
4. $99,990x=5,246,197$
5. $x=\frac{5,246,197}{99,990}$

> [!important] Key Takeaway: Repeating decimals are [[Rational Numbers]]
> - [[Rational Numbers]] are closed under add./sub. and mult./div.
> - Lemma
> 	- helps you prove the Theorem
> 	- prerequisite
> - Theorem
> 	- helps you prove the Corrolary
> - Corrolary
> 	- a secondary idea that follows from a Theorem


### Example 
If $c\epsilon \mathbb R$ is a root of a polynomial with $\mathbb R$ coefficients, then $c$ is a root of a polynomial with $\mathbb Z$ coefficients

1. Integers are rational numbers with a denominator of 1
	1. $r=\frac a 1=\mathbb Z$
	2. example poly
		1. $p(x)=a_2x^2+a_1x+a_0$, $a_n \epsilon \mathbb Q$
		2. let $c\epsilon \mathbb R$ such that $p(c)=0$, by definition of root
		3. $a_2c^2+a_1c+a_0=0$ by substituting $c$  to $x$
		4. then $\frac {r_2} {s_2}c^2 + \frac {r_1}{s_1}c + \frac{r_0}{s_0} = 0$
		5. If we multiply by common denominator ^96814b
			1. $r_2s_1s_0c^2 + r_1s_2s_0c + r_0s_1s_2 = 0$
			2. $\therefore c$ is a root of $r_2s_1s_0c^2 + r_1s_2s_0c + r_0s_1s_2 = 0$
				1. where each term is $\mathbb Z$
2. For HW,
	1. $p(x)=\frac {a_n}{b_n}x^n+\frac{a_{n-1}}{b_{n-1}}x^{n-1}+...+\frac{a_0}{b_0}$
	2. Construct $q(x)$ in a similar way to [[Rational Numbers#^96814b]]
	3. Make sure variables are defined

