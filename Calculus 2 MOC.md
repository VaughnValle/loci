


# Study Guide: Calculus Topics

## 1. Fundamental Theorem of Calculus and Net Change
- **Fundamental Theorem of Calculus (FTC)**:
  - **Part 1**: If $f$ is continuous on $[a, b]$, then the function $F(x) = \int_a^x f(t) \, dt$ is continuous on $[a, b]$, differentiable on $(a, b)$, and $F'(x) = f(x)$.
  - **Part 2**: If $F$ is an antiderivative of $f$ on $[a, b]$, then 
  $$
  \int_a^b f(x) \, dx = F(b) - F(a).
  $$

- **Net Change Theorem**: 
  - If $f(t)$ represents the rate of change of a quantity over time, then the net change over the interval $[a, b]$ can be expressed as:
  $$
  \text{Net Change} = \int_a^b f(t) \, dt.
  $$

## 2. The Substitution Rule
- **Basic Idea**: Used to simplify integration by changing variables.
- If $u = g(x)$ is a differentiable function, then:
  $$
  \int f(g(x)) g'(x) \, dx = \int f(u) \, du.
  $$
- **Steps**:
  1. Choose $u = g(x)$.
  2. Compute $du = g'(x) \, dx$.
  3. Rewrite the integral in terms of $u$.
  4. Integrate and substitute back.

## 3. Integration by Parts
- **Formula**: 
  $$
  \int u \, dv = uv - \int v \, du.
  $$
- **Choosing $u$ and $dv$**:
  - Select $u$ (to differentiate) and $dv$ (to integrate) wisely, typically using the acronym LIATE (Logarithmic, Inverse trigonometric, Algebraic, Trigonometric, Exponential).
  
- **Process**:
  1. Differentiate $u$ to find $du$.
  2. Integrate $dv$ to find $v$.
  3. Substitute into the formula and simplify.

## 4. Trigonometric Integrals
- **Common Integrals**:
  - $$
  \int \sin^n(x) \, dx
  $$
  - $$
  \int \cos^n(x) \, dx
  $$
  - Use identities (like $\sin^2(x) + \cos^2(x) = 1$) to reduce powers.
  
- **Integration Techniques**:
  - For odd powers: Save a factor and convert the rest using identities.
  - For even powers: Use 
  $$
  \sin^2(x) = \frac{1 - \cos(2x)}{2}
  $$
  or similar for cosine.
## 5. Trigonometric Substitution
- **When to Use**: For integrals involving $\sqrt{a^2 - x^2}$, $\sqrt{x^2 - a^2}$, or $\sqrt{x^2 + a^2}$.
- **Common Substitutions**: [Trig Identities](https://www2.clarku.edu/faculty/djoyce/trig/identities.html)
  - $x = a \sin(\theta)$ for $\sqrt{a^2 - x^2}$
  - $x = a \sec(\theta)$ for $\sqrt{x^2 - a^2}$
  - $x = a \tan(\theta)$ for $\sqrt{x^2 + a^2}$
- **Steps**:
  1. Make the substitution.
  2. Change $dx$ and the limits of integration if applicable.
  3. Simplify and integrate.
  4. Back substitute to $x$.

## 6. Partial Fractions
- **Use**: To integrate rational functions.
- **Steps**:
  1. Ensure the degree of the numerator is less than that of the denominator.
  2. Factor the denominator into linear and/or irreducible quadratic factors.
  3. Set up the partial fraction decomposition:
  $$
  \frac{P(x)}{Q(x)} = \frac{A}{(linear)} + \frac{Bx + C}{(quadratic)} + ...
  $$
  4. Multiply through by the denominator and solve for coefficients.
  5. Integrate each term separately.

## 7. Numerical Integration
- **Methods**:
  - **Trapezoidal Rule**: 
  $$
  \int_a^b f(x) \, dx \approx \frac{b - a}{2}(f(a) + f(b)).
  $$
  
  - **Simpson's Rule**: 
  $$
  \int_a^b f(x) \, dx \approx \frac{b - a}{6}(f(a) + 4f\left(\frac{a+b}{2}\right) + f(b)).
  $$

- **Error Analysis**: Understand how the error decreases with more subdivisions, particularly for trapezoidal and Simpson's rules.

---

### Tips for Midterm
- Practice problems for each topic to reinforce concepts.
- Work through a variety of integral types to build confidence.
- Review any example problems or past exams if available.

Good luck with your studying! You've got this!