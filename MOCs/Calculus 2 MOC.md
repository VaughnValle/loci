---
tags:
  - calculus
type: moc
---

### FTC & Net Change
$\int_a^b F'(x) \, dx = F(b) - F(a)$
*Key:* Definite integral of rate of change = net change.

### U-Substitution (IDP & Trig-Sub)
* **U-Sub:** Identify $u = g(x)$ and $du = g'(x) \, dx$. Change limits for definite integrals.
* **Trig-Sub:**
    * $\sqrt{a^2 - x^2} \implies x = a \sin(\theta)$
    * $\sqrt{a^2 + x^2} \implies x = a \tan(\theta)$
    * $\sqrt{x^2 - a^2} \implies x = a \sec(\theta)$
    * *Key:* Substitute back to $x$.

### Partial Fractions
Decompose $\frac{P(x)}{Q(x)}$ into simpler fractions based on factors of $Q(x)$ (degree $P <$ degree $Q$).

### Trigonometric Integrals
Use trig identities (e.g., $\sin^2(x) + \cos^2(x) = 1$) to simplify integrands.

### Numerical Integration
Approximate $\int_a^b f(x) \, dx$ using Midpoint, Trapezoidal, or Simpson's Rules.

### Improper Integrals
Evaluate using limits for infinite bounds or discontinuities: $\lim_{b \to \infty} \int_a^b f(x) \, dx$.

### Area Between Curves
$\int_a^b |f(x) - g(x)| \, dx$ (upper - lower).

### Solids of Revolution
* **Disk/Washer:** $V = \pi \int r^2 \, dx/dy$
* **Cylindrical Shells:** $V = 2\pi \int rh \, dx/dy$
* *Key:* Consider the axis of rotation.

### Volume with Cross-Sections
$V = \int_a^b A(x) \, dx$ (or $dy$), where $A$ is the cross-sectional area.

### Arc Length
$L = \int_a^b \sqrt{1 + (f'(x))^2} \, dx$ (for $y=f(x)$).

### Separable Equations
Rewrite as $f(y) \, dy = g(x) \, dx$ and integrate both sides.

### Modeling with Diff Eq
Translate scenarios into differential equations and solve using initial conditions.

### Sequences & Series
Sequences are lists, series are sums. Focus on convergence/divergence as $n \to \infty$.

### Integral Test
$\sum f(n)$ converges iff $\int f(x) \, dx$ converges (for continuous, positive, decreasing $f$).

### Comparison Test
Compare with known convergent/divergent series (Direct & Limit Comparison).

### Alternating Series Test
Converges if $b_n > 0$, $b_{n+1} \le b_n$, and $\lim_{n \to \infty} b_n = 0$ for $\sum (-1)^{n-1} b_n$.

### Abs Convergence, Ratio & Root
* **Absolute Convergence:** $\sum |a_n|$ converges $\implies \sum a_n$ converges.
* **Ratio Test:** $L = \lim |\frac{a_{n+1}}{a_n}|$. $L<1$ conv, $L>1$ div, $L=1$ inconclusive.
* **Root Test:** $L = \lim \sqrt[n]{|a_n|}$. $L<1$ conv, $L>1$ div, $L=1$ inconclusive.




### Strat for Testing Series
Divergence Test -> Geometric/p-series -> Telescoping -> Integral/Comparison -> Alternating -> Ratio/Root.
See this [[Convergence Test Table]]
### Power Series
$\sum_{n=0}^\infty c_n (x-a)^n$. Find interval and radius of convergence.

### Taylor & Maclaurin Series
* **Taylor:** $f(x) = \sum_{n=0}^\infty \frac{f^{(n)}(a)}{n!} (x-a)^n$
* **Maclaurin ($a=0$):** $f(x) = \sum_{n=0}^\infty \frac{f^{(n)}(0)}{n!} x^n$

### Taylor Polynomials
$T_n(x) = \sum_{i=0}^n \frac{f^{(i)}(a)}{i!} (x-a)^i$ (finite degree approximation).