_proudly made in [Obsidian.md](http://obsidian.md/)_
### Problem 1

**(a)** $\sum_{n=2}^{\infty}\frac{1}{(\ln(\ln n))^{n}}$

Let $a_n = \frac{1}{(\ln(\ln n))^{n}}$. Using the Root Test:
$$L = \lim_{n\to\infty} \sqrt[n]{|a_n|} = \lim_{n\to\infty} \sqrt[n]{\left|\frac{1}{(\ln(\ln n))^{n}}\right|} = \lim_{n\to\infty} \frac{1}{\ln(\ln n)}$$
Since $\ln(\ln n) \to \infty$ as $n \to \infty$,
$$L = 0$$
Because $L = 0 < 1$, the series **converges** by the Root Test.

**(b)** $\sum_{n=2}^{\infty}\frac{n^{-n}x^{n}}{\ln(n)} = \sum_{n=2}^{\infty}\frac{x^{n}}{n^{n}\ln(n)}$

Let $a_n = \frac{x^{n}}{n^{n}\ln(n)}$. Using the Root Test:
$$L = \lim_{n\to\infty} \sqrt[n]{|a_n|} = \lim_{n\to\infty} \sqrt[n]{\left|\frac{x^{n}}{n^{n}\ln(n)}\right|} = |x| \lim_{n\to\infty} \frac{1}{n (\ln n)^{1/n}}$$
We know $\lim_{n\to\infty} (\ln n)^{1/n} = 1$ (by checking $\lim_{n\to\infty} \frac{\ln(\ln n)}{n} = 0$).
So,
$$L = |x| \lim_{n\to\infty} \frac{1}{n \cdot 1} = |x| \cdot 0 = 0$$
Since $L = 0 < 1$ for all $x$, the series **converges** for all $x$ by the Root Test ($R=\infty$).

---

### Problem 2

Show that $\int_{0}^{a} e^{-x^2/2} dx = \sum_{n=0}^{\infty}\frac{(-1)^{n}a^{2n+1}}{n!2^{n}(2n+1)}$.

The Maclaurin series for $e^u$ is $e^u = \sum_{n=0}^{\infty} \frac{u^n}{n!}$.
Let $u = -x^2/2$:
$$e^{-x^2/2} = \sum_{n=0}^{\infty} \frac{(-x^2/2)^n}{n!} = \sum_{n=0}^{\infty} \frac{(-1)^n x^{2n}}{2^n n!}$$
Integrating term-by-term from $0$ to $a$:
$$\int_{0}^{a} e^{-x^2/2} dx = \int_{0}^{a} \left( \sum_{n=0}^{\infty} \frac{(-1)^n x^{2n}}{2^n n!} \right) dx$$
$$= \sum_{n=0}^{\infty} \frac{(-1)^n}{2^n n!} \left( \int_{0}^{a} x^{2n} dx \right)$$
$$= \sum_{n=0}^{\infty} \frac{(-1)^n}{2^n n!} \left[ \frac{x^{2n+1}}{2n+1} \right]_{0}^{a}$$
$$= \sum_{n=0}^{\infty} \frac{(-1)^n}{2^n n!} \left( \frac{a^{2n+1}}{2n+1} \right)$$
$$= \sum_{n=0}^{\infty} \frac{(-1)^{n}a^{2n+1}}{n!2^{n}(2n+1)}$$

---

### Problem 3

**(a)** Approximate $\int_{0}^{1}e^{-\frac{1}{2}x^{2}}dx$ to four decimal places.

Using the series from Problem 2 with $a=1$:
$$S = \sum_{n=0}^{\infty} \frac{(-1)^{n}}{n!2^{n}(2n+1)}$$
The terms are $b_n = \frac{1}{n!2^{n}(2n+1)}$. This is a converging alternating series. We need the error $|R_k| \le b_{k+1} < 0.00005$.
$b_0 = 1$
$b_1 = 1/6 \approx 0.166667$
$b_2 = 1/40 = 0.025$
$b_3 = 1/336 \approx 0.002976$
$b_4 = 1/3456 \approx 0.000289$
$b_5 = 1/42240 \approx 0.0000236$
Since $b_5 < 0.00005$, we need $k=4$.
$$S_4 = b_0 - b_1 + b_2 - b_3 + b_4$$
$$S_4 = 1 - \frac{1}{6} + \frac{1}{40} - \frac{1}{336} + \frac{1}{3456}$$
$$S_4 \approx 1 - 0.166667 + 0.025 - 0.002976 + 0.000289 \approx 0.855646$$
Rounded to four decimal places, the approximation is $\mathbf{0.8556}$.

**(b)** Compute $M_n$ for $\int_{0}^{1}e^{-x^{2}/2}dx$ using the same number of terms (5 terms, so n=5).

$\Delta x = (1-0)/5 = 0.2$. Midpoints: $0.1, 0.3, 0.5, 0.7, 0.9$.
Let $f(x) = e^{-x^2/2}$.
$$M_5 = \Delta x [f(0.1) + f(0.3) + f(0.5) + f(0.7) + f(0.9)]$$
$$M_5 = 0.2 [e^{-0.005} + e^{-0.045} + e^{-0.125} + e^{-0.245} + e^{-0.405}]$$
$$M_5 \approx 0.2 [0.995012 + 0.955997 + 0.882497 + 0.782704 + 0.666977]$$
$$M_5 \approx 0.2 [4.283187] \approx \mathbf{0.856637}$$

**(c)** Which approximation is more accurate?

The error bound for $S_4$ is $b_5 \approx 0.0000236$. The actual error is $|0.855624 - 0.855646| \approx 0.000022$.
The error for $M_5$ is $|0.855624 - 0.856637| \approx 0.001013$.
The **Alternating Series approximation ($S_4$)** is more accurate.

---

### Problem 4

Series for $a=3.8$: $\sum_{n=0}^{\infty}\frac{(-1)^{n}(3.8)^{2n+1}}{n!2^{n}(2n+1)}$. Let $b_n = \frac{(3.8)^{2n+1}}{n!2^{n}(2n+1)}$.

**(a)** Find $n_{0}$ after which $b_n$ decreases.

Calculating terms:
$b_0 \approx 3.8$
$b_1 \approx 9.1453$
$b_2 \approx 19.8088$
$b_3 \approx 34.0755$
$b_4 \approx 47.8623$
$b_5 \approx 56.5896$
$b_6 \approx 57.6518$
$b_7 \approx 51.5765$
$b_8 \approx 41.1840$
The terms increase up to $b_6$ and then start decreasing. So, $\mathbf{n_0 = 6}$.

**(b)** How do we know $n_0=6$ is correct?

We look at the ratio $\frac{b_{n+1}}{b_n}$:
$$\frac{b_{n+1}}{b_n} = \frac{7.22(2n+1)}{(n+1)(2n+3)}$$
We need this ratio to be less than 1:
$$\frac{7.22(2n+1)}{(n+1)(2n+3)} < 1$$
$$14.44n + 7.22 < 2n^2 + 5n + 3$$
$$0 < 2n^2 - 9.44n - 4.22$$
The quadratic $2x^2 - 9.44x - 4.22 = 0$ has a positive root at $x \approx 5.1312$.
The inequality $2n^2 - 9.44n - 4.22 > 0$ holds for integers $n \ge 6$.
Thus, $b_{n+1} < b_n$ for $n \ge 6$, confirming $n_0=6$.

**(c)** Smallest number of terms for error < 0.0005?

We need $|R_k| \le b_{k+1} < 0.0005$, where $k \ge n_0=6$.
Calculating more $b_n$:
... (calculations from previous response) ...
$b_{21} \approx 0.002074$
$b_{22} \approx 0.000652$
$b_{23} \approx 0.0001975$
We need $b_{k+1} < 0.0005$. This occurs for $b_{23}$.
So, we need $k+1=23$, which means $k=22$.
Since $k=22 \ge 6$, this is valid. The partial sum $S_{22}$ includes terms from $n=0$ to $n=22$.
This requires $\mathbf{23}$ terms.

---

### Problem 5

Series $S=\sum_{n=1}^{\infty}\frac{1}{n^{2}}$.

**(a)** Verify Integral Test hypotheses for $f(x) = 1/x^2$ on $[1, \infty)$.
1.  $f(x) = 1/x^2$ is continuous on $[1, \infty)$. (Ok, since $x \neq 0$)
2.  $f(x) = 1/x^2 > 0$ for $x \ge 1$. (Ok)
3.  $f'(x) = -2/x^3 < 0$ for $x \ge 1$. So $f(x)$ is decreasing. (Ok)
All hypotheses are satisfied.

**(b)** Compute $S_{8}=\sum_{n=1}^{8}\frac{1}{n^{2}}$ to 5 decimal places.
$$S_8 = 1 + \frac{1}{4} + \frac{1}{9} + \frac{1}{16} + \frac{1}{25} + \frac{1}{36} + \frac{1}{49} + \frac{1}{64}$$
$$S_8 \approx 1.5274221 \approx \mathbf{1.52742}$$

**(c)** Compute $I_{8}=\int_{8}^{\infty}\frac{1}{x^{2}}dx$ and $I_{9}=\int_{9}^{\infty}\frac{1}{x^{2}}dx$.
$$I_N = \int_{N}^{\infty} x^{-2} dx = \left[ -x^{-1} \right]_{N}^{\infty} = \lim_{t\to\infty} (-\frac{1}{t}) - (-\frac{1}{N}) = \frac{1}{N}$$
$$I_8 = \frac{1}{8} = \mathbf{0.125}$$
$$I_9 = \frac{1}{9} \approx \mathbf{0.11111}$$

**(d)** Find an interval containing $S$ using $S_8 + I_9 \le S \le S_8 + I_8$.
Lower bound: $S_8 + I_9 \approx 1.5274221 + 0.1111111 = 1.6385332$
Upper bound: $S_8 + I_8 = 1.5274221 + 0.125 = 1.6524221$
The interval is $[\mathbf{1.63853}, \mathbf{1.65242}]$.

---

### Problem 6

Repeat 5(b-d) for $S=\sum_{n=1}^{\infty}\frac{1}{n^{4}}$. ($f(x)=1/x^4$ satisfies hypotheses).

**(b)** Compute $S_8 = \sum_{n=1}^{8}\frac{1}{n^{4}}$ to 5 decimal places.
$$S_8 = 1 + \frac{1}{16} + \frac{1}{81} + \frac{1}{256} + \frac{1}{625} + \frac{1}{1296} + \frac{1}{2401} + \frac{1}{4096}$$
$$S_8 \approx 1.0817840 \approx \mathbf{1.08178}$$

**(c)** Compute $I_8 = \int_{8}^{\infty}\frac{1}{x^{4}}dx$ and $I_9 = \int_{9}^{\infty}\frac{1}{x^{4}}dx$.
$$I_N = \int_{N}^{\infty} x^{-4} dx = \left[ \frac{x^{-3}}{-3} \right]_{N}^{\infty} = \lim_{t\to\infty} (-\frac{1}{3t^3}) - (-\frac{1}{3N^3}) = \frac{1}{3N^3}$$
$$I_8 = \frac{1}{3(8^3)} = \frac{1}{1536} \approx \mathbf{0.00065}$$
$$I_9 = \frac{1}{3(9^3)} = \frac{1}{2187} \approx \mathbf{0.00046}$$

**(d)** Find an interval containing $S$.
Lower bound: $S_8 + I_9 \approx 1.0817840 + 0.0004572 = 1.0822412$
Upper bound: $S_8 + I_8 \approx 1.0817840 + 0.0006510 = 1.0824350$
The interval is $[\mathbf{1.08224}, \mathbf{1.08244}]$.

---

### Problem 7

Repeat 5(b-d) for $S=\sum_{n=1}^{\infty}\frac{1}{n^{6}}$. ($f(x)=1/x^6$ satisfies hypotheses). Use 6 decimal places.

**(b)** Compute $S_8 = \sum_{n=1}^{8}\frac{1}{n^{6}}$ to 6 decimal places.
$$S_8 = 1 + \frac{1}{64} + \frac{1}{729} + \frac{1}{4096} + \frac{1}{15625} + \frac{1}{46656} + \frac{1}{117649} + \frac{1}{262144}$$
$$S_8 \approx 1.01733862 \approx \mathbf{1.017339}$$

**(c)** Compute $I_8 = \int_{8}^{\infty}\frac{1}{x^{6}}dx$ and $I_9 = \int_{9}^{\infty}\frac{1}{x^{6}}dx$.
$$I_N = \int_{N}^{\infty} x^{-6} dx = \left[ \frac{x^{-5}}{-5} \right]_{N}^{\infty} = \lim_{t\to\infty} (-\frac{1}{5t^5}) - (-\frac{1}{5N^5}) = \frac{1}{5N^5}$$
$$I_8 = \frac{1}{5(8^5)} = \frac{1}{163840} \approx \mathbf{0.000006}$$
$$I_9 = \frac{1}{5(9^5)} = \frac{1}{295245} \approx \mathbf{0.000003}$$

**(d)** Find an interval containing $S$.
Lower bound: $S_8 + I_9 \approx 1.01733862 + 0.00000338 = 1.01734200$
Upper bound: $S_8 + I_8 \approx 1.01733862 + 0.00000610 = 1.01734472$
The interval is $[\mathbf{1.017342}, \mathbf{1.017345}]$.

---

### Problem 8

Taylor Poly for $f(x)=\sin x$ at $a=0$.

**(a)** $\sin(\pi/2) = \mathbf{1}$.

**(b)** Find $P_3(x)$ and use it to estimate $f(\pi/2)$.
$f(0)=0, f'(0)=1, f''(0)=0, f'''(0)=-1$.
$$P_3(x) = f(0) + f'(0)x + \frac{f''(0)}{2!}x^2 + \frac{f'''(0)}{3!}x^3 = x - \frac{x^3}{6}$$
$$P_3(\pi/2) = \frac{\pi}{2} - \frac{(\pi/2)^3}{6} = \frac{\pi}{2} - \frac{\pi^3}{48}$$
$$P_3(\pi/2) \approx 1.57080 - 0.64596 \approx \mathbf{0.92484}$$

**(c)** State the exact error.
Error $= |f(\pi/2) - P_3(\pi/2)| = |1 - ( \frac{\pi}{2} - \frac{\pi^3}{48} )|$
Error $\approx |1 - 0.92484| = \mathbf{0.07516}$

**(d)** Find $M = \max |f^{(4)}(x)|$ on $[0, \pi/2]$.
$f^{(4)}(x) = \sin x$.
$M = \max_{z \in [0, \pi/2]} |\sin z|$. Since $\sin z$ increases from 0 to 1 on $[0, \pi/2]$, the max is $1$.
$M = \mathbf{1}$.

**(e)** Find the error bound $E(3, \pi/2)$.
$$E(3, \pi/2) = \frac{M}{(3+1)!}|\pi/2 - 0|^{3+1} = \frac{1}{4!} \left(\frac{\pi}{2}\right)^4 = \frac{\pi^4}{384}$$
$$E(3, \pi/2) \approx \frac{97.4091}{384} \approx 0.25367$$
To 4 decimal places: $\mathbf{0.2537}$.

**(f)** Verify error (c) < bound (e).
$0.07516 < 0.25367$. Verified.

---

### Problem 9

**(a)** Use $P_3(x) = x - x^3/6$ to estimate $f(\pi/25)$.
$$P_3(\pi/25) = \frac{\pi}{25} - \frac{(\pi/25)^3}{6}$$
$$P_3(\pi/25) \approx 0.1256637 - \frac{(0.1256637)^3}{6}$$
$$P_3(\pi/25) \approx 0.1256637 - 0.00033115 \approx 0.12533255$$
Estimate $\approx \mathbf{0.125333}$.

**(b)** Find an overapproximation for $M = \max |f^{(4)}(x)|$ on $[0, \pi/25]$.
$f^{(4)}(x) = \sin x$. We need $M \ge \max_{z \in [0, \pi/25]} |\sin z|$.
Since $|\sin z| \le 1$ for all $z$, we can use $\mathbf{M=1}$.

**(c)** Find the error bound $E(3, \pi/25)$ using $M=1$.
$$E(3, \pi/25) = \frac{M}{(3+1)!}|\pi/25 - 0|^{3+1} = \frac{1}{4!} \left(\frac{\pi}{25}\right)^4$$
$$E(3, \pi/25) \approx \frac{1}{24} (0.1256637)^4 \approx \frac{0.00024985}{24} \approx 0.00001041$$
Error bound $\approx \mathbf{0.000011}$.

**(d)** Determine an interval guaranteed to contain $\sin(\pi/25)$.
Interval is $[P_3(\pi/25) - E(3, \pi/25), P_3(\pi/25) + E(3, \pi/25)]$.
Using values from (a) and (c):
Lower bound: $0.12533255 - 0.00001041 = 0.12532214$
Upper bound: $0.12533255 + 0.00001041 = 0.12534296$
The interval is $[\mathbf{0.125322}, \mathbf{0.125343}]$.