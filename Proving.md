---
tags:
  - "#discrete-math"
---
# Topics
- Paired arguments that have different truth values
- proofing
# Examples

## Proof of Statement
#### There are real numbers $a$ and $b$ such that $\sqrt{a+b}=\sqrt a + \sqrt b$
Proof:
1. $\exists a,b \epsilon \mathbb R$ such that $\sqrt{a+b}=\sqrt a + \sqrt b$
2. let $a=1$, $b=0$
3. $\sqrt {1+0} = \sqrt 1 + \sqrt 0$
4. $\sqrt1 = \sqrt 1$
5. $\therefore$  $\exists a,b \epsilon \mathbb R$ such that $\sqrt{a+b}=\sqrt a + \sqrt b$ OR Statement is true
6. $\square$

#### Every positive even number less than 2b can be expressed as a sum of three of fewer perfect squares (e.g. $10=1^2+3^2$)
Proof:
1. Examples

## Disproof by Counterexample
#### For every integer $p$, if $p$ is prime then $p^2-1$ is even
Proof:
1. $\forall p\epsilon \mathbb Z$, if $p$ is prime, then $p^2-1$ is even
2. let $p^2-1=2k$, where $k\epsilon \mathbb Z$ by [[definition of odd and even integers]]
3. let $p=2$, then $2^2-1 = 3$
4. we know that $3=2k+1$ when $k=1$, by [[definition of odd and even integers]] ^a599e8
5. $p^2-1$ is odd from [[Proving#^a599e8]]
6. $\therefore$ Statement is false 
7. $\square$


#### There are distinct integers $m$ and $n$ such that $\frac 1 m + \frac 1 n$ is an integer.
Proof:
1. $\exists m,n\epsilon \mathbb Z$ such that $(\frac 1 m + \frac 1 n) \epsilon \mathbb Z$
2. Addition is closed on the set of integers
3. Hence, $\frac 1 m \epsilon \mathbb Z$ ^ $\frac 1 n \epsilon \mathbb Z$  ^3ef4d4
4. let $m=-1$ and $n=1$: $m,n\epsilon \mathbb Z$
5. [[Proving#^3ef4d4]] is satisfied, $-1+1=0$
6. $0\epsilon \mathbb Z$
7. $\therefore$ Statement is true
8. $\square$

#### There is an integer $n$ such that $2n^2-5n+2$ is prime
Proof:
1. $\exists n\epsilon \mathbb Z$ such that $2n^2-5n+2$ is prime
2. let $n=0$: $n\epsilon \mathbb Z$
3. $2n^2-5n+2=0-0+2$ by substitution
4. 2 is prime 
5. $\therefore$ Statement is true
6. $\square$

#### For every odd integer $n$, $n^2$ is odd
Proof:
1. $\forall n\epsilon\mathbb Z -2\mathbb Z$
2. Suppose $n$ is any odd integer. By [[definition of odd and even integers]], $n=2k+1$where $k\epsilon \mathbb Z$
3. let $n=1$, then $n^2 = (2k+1)^2$ ^af0c50
4. From [[Proving#^af0c50]], $1^2=4k^2+2k+1^2$
5. let $k=0$, then $1^2=0+0+1$ ^1017cc
6. $1=1$ from [[Proving#^1017cc]]
7. $n^2=1$ which is odd by [[definition of odd and even integers]]
8. $\therefore$ Statement is true
9. $\square$