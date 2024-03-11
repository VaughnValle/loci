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


### If $r$ and $s$ are any two rational numbers, then $\frac {r+s} 2$ is rational
Proof:
1. $\forall r,s \in \mathbb Q, \frac {r+s} 2 \in \mathbb Q$
2. Suppose $r$ and $s$ are any two numbers $\in \mathbb Q$
3. By [[definition of rational numbers]], $r=\frac a b, s = \frac c d$
4. For some integers $a,b,c,d$, $b\neq 0, d\neq 0$
5. Thus, $\frac {r+s} 2 =\frac {\frac a b + \frac c d} 2$, by substitution
6. Then, $\frac {ad+bc}{2bd}$
7. let $p = ad+bc$, $q=2bd$, so $p,q \in \mathbb Z$ and $q\neq 0$
8. Thus $\frac {r+s} 2 = \frac p q$
9. $\therefore$ by [[definition of rational numbers]], statement is true
10. $\square$

Own
1. Since $\mathbb Q$ are closed under addition/subtraction, $r+s \in \mathbb Q$
2. Since $\mathbb Q$ are closed under division except when the divisor is $0$, then $\frac {r+s} 2 \in \mathbb Q$ 
3. $\therefore$ Statement is true
4. $\square$

### For all real numbers $a$ and $b$, if $a<b$ then $a < \frac {a+b} 2 < b$
Proof:
1. $\forall a,b\in \mathbb R$, if $a<b$ then $a<\frac{a+b} 2 < b$
2. $a < b$, then $a+a < b+a$
3. Then, $2a < a+b = a < \frac {a+b} 2$ ^3f96a4
4. Similarly, $a+b < b+b$
5. Then, $a+b < 2b = b > \frac {a+b} 2$ ^c5d07c
6. $\therefore$ $a < \frac {a+b} 2 < b$ by [[Proving#^3f96a4]] and [[Proving#^c5d07c]]
7. $\square$

### T or F? If $a$ is any odd integer, then $a^2+a$ is even.
Proof:
1. let $a$ be any odd integer
2. By [[definition of odd and even integers]], $a=2k+1,$ for some $k\in \mathbb Z$
3. Thus $a^2+a = (2k+1)^2 + (2k+1) = 4k^2 + 4k + 1 + 2k + 1$
4. Then, $4k^2+6k+2$ ^ca443d
5. We can express [[Proving#^ca443d]] in factored form $2(2k^2+3k+1)$
6. let $p=2k^2+3k+1$, hence $a^2+a = 2p$ where $p\in \mathbb Z$
7. $\therefore$ $a^2+a$ is even by [[definition of odd and even integers]]
8. Statement is true
9. $\square$

### For any rational number s, $5s^3 + 8s^2 - 8$ is rational
Given the following
1. the square of any rational number is rational ^6bfac2
2. the product of any rational number is rational ^986bd9
3. the difference of any rational number is rational
Proof: ^f6b7d3
1. By [[Proving#^6bfac2]], $s^2 \in \mathbb Q$
2. By [[Proving#^986bd9]], $s^3 = s^2 \cdot s \in \mathbb Q$
3. By [[Proving#^6bfac2]], $5s^3 = 5\cdot s^3 \in \mathbb Q$
4. Continue doing the proof for each term
5. By [[Proving#^f6b7d3]], $5s^3 + 8s^2 - 8 \in \mathbb Q$
6. $\therefore$ Statement is true
7. $\square$


8. $\forall s \in \mathbb Q$, $5s^3+8s^2-7 \in \mathbb Q$
9. By [[definition of rational numbers]], $s=\frac a b$ for any $a,b \in \mathbb Z$


Proof:
1. 