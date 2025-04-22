_proudly made in [Obsidian.md](https://obsidian.md/)_

## Problem Set 4
**1. Recursive Sequence $a_{n+1}=\frac{3a_{n}+4}{2a_{n}+3}$, $a_{0}=6$**
**(a) First five terms ($a_1$ to $a_5$) approximated to 8 decimal places:**
* $a_0 = 6$
* $a_1 = \frac{3a_0 + 4}{2a_0 + 3} = \frac{3(6)+4}{2(6)+3} = \frac{18+4}{12+3} = \frac{22}{15} \approx 1.46666667$
* $a_2 = \frac{3a_1 + 4}{2a_1 + 3} = \frac{3(22/15)+4}{2(22/15)+3} = \frac{66/15 + 60/15}{44/15 + 45/15} = \frac{126/15}{89/15} = \frac{126}{89} \approx 1.41573034$
* $a_3 = \frac{3a_2 + 4}{2a_2 + 3} = \frac{3(126/89)+4}{2(126/89)+3} = \frac{378/89 + 356/89}{252/89 + 267/89} = \frac{734/89}{519/89} = \frac{734}{519} \approx 1.41425819$
* $a_4 = \frac{3a_3 + 4}{2a_3 + 3} = \frac{3(734/519)+4}{2(734/519)+3} = \frac{2202/519 + 2076/519}{1468/519 + 1557/519} = \frac{4278/519}{3025/519} = \frac{4278}{3025} \approx 1.41421356$
* $a_5 = \frac{3a_4 + 4}{2a_4 + 3} = \frac{3(4278/3025)+4}{2(4278/3025)+3} = \frac{12834/3025 + 12100/3025}{8556/3025 + 9075/3025} = \frac{24934/3025}{17631/3025} = \frac{24934}{17631} \approx 1.41421356$

Summary:
$a_1 \approx 1.46666667$
$a_2 \approx 1.41573034$
$a_3 \approx 1.41425819$
$a_4 \approx 1.41421356$
$a_5 \approx 1.41421356$

**(b) Exact value of the limit:**
Assume the sequence converges to a limit $L$. Then as $n \to \infty$, $a_{n+1} \to L$ and $a_n \to L$.
The recursive relation becomes:
$$L = \frac{3L+4}{2L+3}$$
$$L(2L+3) = 3L+4$$
$$2L^2 + 3L = 3L + 4$$
$$2L^2 = 4$$
$$L^2 = 2$$
$$L = \pm \sqrt{2}$$
Since $a_0 = 6 > 0$, and if $a_n > 0$, then $3a_n+4 > 0$ and $2a_n+3 > 0$, so $a_{n+1} > 0$. All terms are positive. Therefore, the limit must be positive.
The exact value of the limit is $L = \sqrt{2}$.

**2. Limits of Recursively Defined Sequences**

Assume convergence to a limit $L$.

**(a) $a_{n+1}=\frac{1}{2}(a_{n}+\frac{2}{a_{n}})$, $a_{0}=1$**
$$L = \frac{1}{2}(L+\frac{2}{L})$$
$$2L = L + \frac{2}{L}$$
$$L = \frac{2}{L}$$
$$L^2 = 2$$
$$L = \pm \sqrt{2}$$
Since $a_0=1 > 0$, and if $a_n > 0$, $a_{n+1} = \frac{1}{2}(a_n + \frac{2}{a_n}) > 0$, all terms are positive.
The limit is $L = \sqrt{2}$.

**(b) $a_{n+1}=\frac{1}{2}(a_{n}+\frac{3}{a_{n}})$ with $a_{0}=1$**
$$L = \frac{1}{2}(L+\frac{3}{L})$$
$$2L = L + \frac{3}{L}$$
$$L = \frac{3}{L}$$
$$L^2 = 3$$
$$L = \pm \sqrt{3}$$
Since $a_0=1 > 0$, all terms are positive.
The limit is $L = \sqrt{3}$.

**(c) $a_{n+1}=\frac{2}{3}a_{n}+\frac{4}{3a_{n}^{2}}$ with $a_{0}=1$**
$$L = \frac{2}{3}L + \frac{4}{3L^2}$$
$$L - \frac{2}{3}L = \frac{4}{3L^2}$$
$$\frac{1}{3}L = \frac{4}{3L^2}$$
$$L = \frac{4}{L^2}$$
$$L^3 = 4$$
$$L = \sqrt[3]{4}$$
Since $a_0=1 > 0$, all terms are positive.
The limit is $L = \sqrt[3]{4}$.

**3. Convergence of $\{\frac{\cos(n\pi x)}{n^{3}}\}_{n=1}^{\infty}$**

Let $a_n = \frac{\cos(n\pi x)}{n^{3}}$. We know that for any real number $x$ and any integer $n$, $-1 \le \cos(n\pi x) \le 1$.
Therefore,
$$-\frac{1}{n^3} \le \frac{\cos(n\pi x)}{n^3} \le \frac{1}{n^3}$$
We know that $\lim_{n\to\infty} -\frac{1}{n^3} = 0$ and $\lim_{n\to\infty} \frac{1}{n^3} = 0$.
By the Squeeze Theorem, since $a_n$ is squeezed between two sequences that both converge to 0, the sequence $a_n$ must also converge to 0.

The sequence converges, and its limit is 0.

**4. Convergence/Sum of $\sum_{n=1}^{\infty}\ln(\frac{n}{n+1})$**

Let $a_n = \ln(\frac{n}{n+1}) = \ln(n) - \ln(n+1)$.
This is a telescoping series. Let's look at the partial sums $S_N$:
$$S_N = \sum_{n=1}^{N} [\ln(n) - \ln(n+1)]$$
$$S_N = [\ln(1) - \ln(2)] + [\ln(2) - \ln(3)] + [\ln(3) - \ln(4)] + \dots + [\ln(N) - \ln(N+1)]$$
$$S_N = \ln(1) - \ln(N+1)$$
Since $\ln(1) = 0$, we have $S_N = -\ln(N+1)$.

Now, we find the limit of the partial sums as $N \to \infty$:
$$\lim_{N\to\infty} S_N = \lim_{N\to\infty} -\ln(N+1) = -\infty$$
Since the limit of the partial sums is $-\infty$, the series **diverges**.

**5. Convergence of $\sum_{n=1}^{\infty}\frac{n-5\sqrt{n}}{1+3n^{2}}$**

Let $a_n = \frac{n-5\sqrt{n}}{1+3n^{2}}$. For large $n$, the term behaves like $\frac{n}{3n^2} = \frac{1}{3n}$.
Let's use the Limit Comparison Test with $b_n = \frac{1}{n}$.
We know that $\sum b_n = \sum \frac{1}{n}$ is the harmonic series, which diverges.

Calculate the limit of the ratio $\frac{a_n}{b_n}$:
$$\lim_{n\to\infty} \frac{a_n}{b_n} = \lim_{n\to\infty} \frac{\frac{n-5\sqrt{n}}{1+3n^{2}}}{\frac{1}{n}}$$
$$= \lim_{n\to\infty} \frac{n(n-5\sqrt{n})}{1+3n^{2}} = \lim_{n\to\infty} \frac{n^2 - 5n^{3/2}}{1+3n^{2}}$$
Divide numerator and denominator by $n^2$:
$$= \lim_{n\to\infty} \frac{1 - 5/n^{1/2}}{1/n^2 + 3} = \frac{1-0}{0+3} = \frac{1}{3}$$
Since the limit is a finite positive number ($1/3$), and the series $\sum b_n$ diverges, the series $\sum a_n$ also **diverges** by the Limit Comparison Test.

**6. Solve $\frac{9}{10}=\sum_{n=2}^{\infty}(1+\frac{3x}{2})^{-n}$**

The series $\sum_{n=2}^{\infty}(1+\frac{3x}{2})^{-n}$ is a geometric series.
Let $y = 1+\frac{3x}{2}$. The series is $\sum_{n=2}^{\infty} y^{-n} = y^{-2} + y^{-3} + y^{-4} + \dots$.
This is a geometric series with first term $a = y^{-2}$ and common ratio $r = y^{-1}$.
The series converges if $|r| < 1$, which means $|y^{-1}| < 1$, or $|y| > 1$.
The sum is $S = \frac{a}{1-r} = \frac{y^{-2}}{1-y^{-1}}$.

We are given $S = \frac{9}{10}$:
$$\frac{9}{10} = \frac{y^{-2}}{1-y^{-1}} = \frac{1/y^2}{(y-1)/y} = \frac{1}{y^2} \cdot \frac{y}{y-1} = \frac{1}{y(y-1)}$$
$$9y(y-1) = 10$$
$$9y^2 - 9y - 10 = 0$$
Using the quadratic formula:
$$y = \frac{-(-9) \pm \sqrt{(-9)^2 - 4(9)(-10)}}{2(9)} = \frac{9 \pm \sqrt{81 + 360}}{18} = \frac{9 \pm \sqrt{441}}{18} = \frac{9 \pm 21}{18}$$
Possible values for $y$:
$y_1 = \frac{9+21}{18} = \frac{30}{18} = \frac{5}{3}$
$y_2 = \frac{9-21}{18} = \frac{-12}{18} = -\frac{2}{3}$

Now substitute back $y = 1+\frac{3x}{2}$:
Case 1: $y = 5/3$
$|y| = 5/3 > 1$, so this is potentially valid.
$1+\frac{3x}{2} = \frac{5}{3} \implies \frac{3x}{2} = \frac{5}{3} - 1 = \frac{2}{3} \implies 3x = \frac{4}{3} \implies x = \frac{4}{9}$.

Case 2: $y = -2/3$
$|y| = |-2/3| = 2/3 < 1$. The series would diverge for this value of $y$. Thus, this case yields no solution for $x$.

The only value of $x$ is $x = \frac{4}{9}$.

**7. Basketball Bounce**

Initial height $h_0 = 5$ ft. Rebound ratio $r = 0.85$. $g=32.2$ ft/s².
Heights: $h_n = h_0 r^n = 5(0.85)^n$.

**(a) Total distance traveled:**
Distance = (Initial drop) + 2 * (Sum of rebound heights)
$$D = h_0 + 2h_1 + 2h_2 + \dots = h_0 + 2 \sum_{n=1}^{\infty} h_n = h_0 + 2 \sum_{n=1}^{\infty} h_0 r^n$$
$$D = h_0 + 2 h_0 r \sum_{n=0}^{\infty} r^n = h_0 + 2 h_0 r \left( \frac{1}{1-r} \right)$$
$$D = h_0 \left( 1 + \frac{2r}{1-r} \right) = h_0 \left( \frac{1-r+2r}{1-r} \right) = h_0 \left( \frac{1+r}{1-r} \right)$$
$$D = 5 \left( \frac{1+0.85}{1-0.85} \right) = 5 \left( \frac{1.85}{0.15} \right) = 5 \left( \frac{185}{15} \right) = 5 \left( \frac{37}{3} \right) = \frac{185}{3} \text{ ft}$$
$D \approx 61.67$ ft.

**(b) Total time to come to rest:**
Time to fall from height $h$ is $t = \sqrt{\frac{2h}{g}}$.
Time for $n$-th fall is $t_n = \sqrt{\frac{2h_n}{g}} = \sqrt{\frac{2 h_0 r^n}{g}}$.
Time to rise to height $h_n$ is equal to the time to fall from $h_n$.
Total Time = (Time for initial drop) + 2 * (Sum of times for subsequent drops)
$$T = t_0 + 2t_1 + 2t_2 + \dots = t_0 + 2 \sum_{n=1}^{\infty} t_n = \sqrt{\frac{2h_0}{g}} + 2 \sum_{n=1}^{\infty} \sqrt{\frac{2 h_0 r^n}{g}}$$
$$T = \sqrt{\frac{2h_0}{g}} \left( 1 + 2 \sum_{n=1}^{\infty} (\sqrt{r})^n \right)$$
The sum is a geometric series: $\sum_{n=1}^{\infty} (\sqrt{r})^n = \frac{\sqrt{r}}{1-\sqrt{r}}$ (since $|\sqrt{r}| < 1$).
$$T = \sqrt{\frac{2h_0}{g}} \left( 1 + 2 \frac{\sqrt{r}}{1-\sqrt{r}} \right) = \sqrt{\frac{2h_0}{g}} \left( \frac{1-\sqrt{r} + 2\sqrt{r}}{1-\sqrt{r}} \right)$$
$$T = \sqrt{\frac{2h_0}{g}} \left( \frac{1+\sqrt{r}}{1-\sqrt{r}} \right)$$
$$T = \sqrt{\frac{2(5)}{32.2}} \left( \frac{1+\sqrt{0.85}}{1-\sqrt{0.85}} \right) = \sqrt{\frac{10}{32.2}} \left( \frac{1+\sqrt{0.85}}{1-\sqrt{0.85}} \right) \text{ s}$$
$$T \approx \sqrt{0.31056} \left( \frac{1+0.92195}{1-0.92195} \right) \approx 0.55728 \left( \frac{1.92195}{0.07805} \right) \approx 0.55728 (24.6246) \approx 13.721 \text{ s}$$

**8. Convergence/Sum of Series $\frac{1}{4}+\frac{2}{16}+\frac{1}{64}+\frac{2}{256}+\frac{1}{1024}+\frac{2}{4096}+\cdot\cdot\cdot$**

The series can be written as $\sum_{k=0}^{\infty} \left( \frac{1}{4^{2k+1}} + \frac{2}{4^{2k+2}} \right)$.

**Method 1: Splitting into two series**
Series 1 (odd terms): $S_1 = \frac{1}{4} + \frac{1}{64} + \frac{1}{1024} + \dots = \sum_{k=0}^{\infty} \frac{1}{4^{2k+1}} = \sum_{k=0}^{\infty} \frac{1}{4 \cdot 16^k}$. Geometric series with $a=1/4, r=1/16$.
$S_1 = \frac{1/4}{1 - 1/16} = \frac{1/4}{15/16} = \frac{4}{15}$.
Series 2 (even terms): $S_2 = \frac{2}{16} + \frac{2}{256} + \frac{2}{4096} + \dots = \sum_{k=0}^{\infty} \frac{2}{4^{2k+2}} = \sum_{k=0}^{\infty} \frac{2}{16 \cdot 16^k}$. Geometric series with $a=2/16=1/8, r=1/16$.
$S_2 = \frac{1/8}{1 - 1/16} = \frac{1/8}{15/16} = \frac{2}{15}$.
Total Sum $S = S_1 + S_2 = \frac{4}{15} + \frac{2}{15} = \frac{6}{15} = \frac{2}{5}$. The series **converges** to $2/5$.

**Method 2: Grouping terms**
$$S = \sum_{k=0}^{\infty} \left( \frac{1}{4^{2k+1}} + \frac{2}{4^{2k+2}} \right) = \sum_{k=0}^{\infty} \left( \frac{1}{4 \cdot 16^k} + \frac{2}{16 \cdot 16^k} \right)$$
$$S = \sum_{k=0}^{\infty} \left( \frac{1}{4} + \frac{2}{16} \right) \frac{1}{16^k} = \sum_{k=0}^{\infty} \left( \frac{1}{4} + \frac{1}{8} \right) \frac{1}{16^k} = \sum_{k=0}^{\infty} \frac{3}{8} \left( \frac{1}{16} \right)^k$$
This is a geometric series with $a=3/8, r=1/16$.
$S = \frac{3/8}{1 - 1/16} = \frac{3/8}{15/16} = \frac{3}{8} \cdot \frac{16}{15} = \frac{6}{15} = \frac{2}{5}$. The series **converges** to $2/5$.

**9. Convergence of $\sum_{n=1}^{\infty}(\sqrt{n^{2}+1}-n)$**

Let $a_n = \sqrt{n^2+1}-n$.
Multiply by the conjugate:
$$a_n = (\sqrt{n^2+1}-n) \frac{\sqrt{n^2+1}+n}{\sqrt{n^2+1}+n} = \frac{(n^2+1) - n^2}{\sqrt{n^2+1}+n} = \frac{1}{\sqrt{n^2+1}+n}$$
Check the limit: $\lim_{n\to\infty} a_n = \lim_{n\to\infty} \frac{1}{\sqrt{n^2+1}+n} = 0$. The Test for Divergence is inconclusive.
Use the Limit Comparison Test with $b_n = \frac{1}{n}$. We know $\sum b_n$ diverges.
$$\lim_{n\to\infty} \frac{a_n}{b_n} = \lim_{n\to\infty} \frac{\frac{1}{\sqrt{n^2+1}+n}}{\frac{1}{n}} = \lim_{n\to\infty} \frac{n}{\sqrt{n^2+1}+n}$$
Divide numerator and denominator by $n$:
$$= \lim_{n\to\infty} \frac{1}{\sqrt{\frac{n^2+1}{n^2}}+1} = \lim_{n\to\infty} \frac{1}{\sqrt{1+1/n^2}+1} = \frac{1}{\sqrt{1+0}+1} = \frac{1}{2}$$
Since the limit is finite and positive ($1/2$), and $\sum \frac{1}{n}$ diverges, the series $\sum (\sqrt{n^2+1}-n)$ also **diverges** by the Limit Comparison Test.