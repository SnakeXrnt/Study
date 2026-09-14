---
title: "Lecture 3 — Integration"
lecture: 3
date: 2026-09-14
slides: ../../lectures_slides/lecture_3.pdf
tags: [calculus-a, lecture, integration]
status: in-progress
---

# Lecture 3 — Integration of Single-Variable Functions

Back to [[00 Index]] · Prev: [[L02 Differentiation]]
Formula sheet: [[Integration Rules]] · Practice: [[Exercise Log#Lecture 3]]

> [!abstract] Big picture
> Differentiation = **slope** (rate of change). Integration = **accumulation** (area, total amount).
> The **Fundamental Theorem of Calculus** says they undo each other, so antiderivatives from [[L02 Differentiation]] let us compute areas without infinite sums.

## 1. Area by rectangles (slides 2–4, 6)
Goal: area $R$ under $f(x)=1-x^2$ on $[0,1]$.
- Split $[0,1]$ into $n$ strips of width $\frac1n$ and add up rectangles:
  - **Left endpoints** $f(0),f(\frac1n),\dots$ → rectangles poke above the curve here (**overestimate**, since $f$ is decreasing).
  - **Right endpoints** $f(\frac1n),\dots,f(1)$ → underestimate.
- $n=2$: left sum $\frac12(1)+\frac12(\frac34)=\frac78$. More strips ⇒ smaller error.
- Exact area = limit as $n\to\infty$:
$$A=\lim_{n\to\infty}\sum_{k=1}^{n}\frac1n\left(1-\frac{k^2}{n^2}\right)=\lim_{n\to\infty}\left(1-\frac{(n+1)(2n+1)}{6n^2}\right)=1-\frac13=\frac23$$

## 2. Sigma notation (slide 5)
$\sum_{k=m}^{n}a_k=a_m+a_{m+1}+\dots+a_n$ (index $k$, start $m$, end $n$, term $a_k$). Example: $\sum_{k=1}^4k^2=30$.

**Formulas to memorise:**
$$\sum_{k=1}^nk=\frac{n(n+1)}2\qquad\sum_{k=1}^nk^2=\frac{n(n+1)(2n+1)}6\qquad\sum_{k=1}^nk^3=\left(\frac{n(n+1)}2\right)^2$$

## 3. The definite integral (slides 7–12)
- **Partition** $P=\{x_0,\dots,x_n\}$ with $a=x_0<x_1<\dots<x_n=b$; $\Delta x_k=x_k-x_{k-1}$.
- **Mesh** $\|P\|$ = widest subinterval.
- **Riemann sum:** $\sum f(c_k)\Delta x_k$ with any sample point $c_k\in[x_{k-1},x_k]$.
- If every Riemann sum approaches the same $I$ as $\|P\|\to0$, $f$ is **integrable** and
$$\int_a^bf(x)\,dx=\lim_{\|P\|\to0}\sum_{k=1}^nf(c_k)\,\Delta x_k$$
- Anatomy: $\int$ (stretched "S" for sum), limits $a$ (lower) and $b$ (upper), integrand $f(x)$, $dx$ names the variable.

**Rules:**
1. Order: $\int_b^a f=-\int_a^b f$
2. Zero width: $\int_a^a f=0$
3. Constant: $\int_a^b kf=k\int_a^b f$
4. Sum/difference: $\int_a^b(f\pm g)=\int_a^b f\pm\int_a^b g$
5. Additivity: $\int_a^b f+\int_b^c f=\int_a^c f$
6. Max–min: $\min f\cdot(b-a)\le\int_a^b f\le\max f\cdot(b-a)$
7. Domination: $f\ge g$ on $[a,b]$ ⇒ $\int_a^b f\ge\int_a^b g$

**Slide 11 example:** $\int_{-1}^1f=5$, $\int_1^4f=-2$, $\int_{-1}^1h=7$:
- $\int_4^1f=2$ (rule 1)
- $\int_{-1}^1(2f+3h)=2(5)+3(7)=31$ (rules 3, 4)
- $\int_{-1}^4f=5+(-2)=3$ (rule 5)

**Area:** if $f\ge0$ on $[a,b]$, area under the curve is $\int_a^bf\,dx$.
- $\int_0^bx\,dx=\lim\frac{b^2(n+1)}{2n}=\frac{b^2}2$ (triangle area ✓).

> [!warning] Definite integral = **signed** area. Where $f<0$ it counts negative.

## 4. Fundamental Theorem of Calculus (slides 13–17)
**FTC Part I** — if $f$ is continuous on $[a,b]$:
$$\frac{d}{dx}\int_a^xf(t)\,dt=f(x)$$
*Why:* the extra area from $x$ to $x+h$ is a thin strip about $h$ wide and $f(x)$ tall, so (extra area)/$h\to f(x)$. The slides squeeze it between $m\le\frac1h\int_x^{x+h}f\le M$.

**With a variable limit (Chain Rule):** $\frac{d}{dx}\int_a^{g(x)}f(t)\,dt=f(g(x))\,g'(x)$
- (a) $y=\int_x^53t\sin t\,dt=-\int_5^x\dots$ ⇒ $y'=-3x\sin x$
- (b) $y=\int_{1+3x^2}^4\frac{1}{2+e^t}dt$ ⇒ $y'=-\frac{6x}{2+e^{1+3x^2}}$

**FTC Part II** — if $F$ is any antiderivative of continuous $f$:
$$\int_a^bf(x)\,dx=F(b)-F(a)=\Big[F(x)\Big]_a^b$$
*Why any $F$ works:* all antiderivatives differ by a constant $C$, which cancels in $F(b)-F(a)$.

## 5. Indefinite integral (slides 16, 18)
$\int f(x)\,dx=F(x)+C$ where $F'=f$.
| | Definite $\int_a^b f\,dx$ | Indefinite $\int f\,dx$ |
|---|---|---|
| Result | a **number** | a **family of functions** |
| $+C$? | no | **yes** |

## 6. Substitution (slides 19–22)
Reverse of the Chain Rule:
$$\int f(g(x))\,g'(x)\,dx=\int f(u)\,du,\quad u=g(x),\ du=g'(x)\,dx$$
**Procedure:** choose $u$ (usually the "inside") → compute $du$ → rewrite everything in $u$ → integrate → substitute back.
- $\int\cos(7\theta+3)\,d\theta$: $u=7\theta+3$, $d\theta=\frac17du$ → $\frac17\sin(7\theta+3)+C$
- $\int x^2e^{x^3}dx$: $u=x^3$, $x^2dx=\frac13du$ → $\frac13e^{x^3}+C$
- $\int x\sqrt{2x+1}\,dx$: $u=2x+1$, $x=\frac{u-1}2$, $dx=\frac12du$ → $\frac14\int(u^{3/2}-u^{1/2})du=\frac1{10}(2x+1)^{5/2}-\frac16(2x+1)^{3/2}+C$

**Definite integrals — change the limits too:** $\int_a^bf(g(x))g'(x)\,dx=\int_{g(a)}^{g(b)}f(u)\,du$
- $\int_{-1}^13x^2\sqrt{x^3+1}\,dx$: $u=x^3+1$; $x=-1\to u=0$, $x=1\to u=2$ → $\int_0^2\sqrt u\,du=\frac23u^{3/2}\Big|_0^2=\frac{4\sqrt2}3$

> [!tip] With new limits in $u$ you never go back to $x$.

## 7. Area between curves (slide 23)
If $f\ge g$ on $[a,b]$: $A=\int_a^b[f(x)-g(x)]\,dx$ (**top − bottom**).
- $y=2-x^2$ and $y=-x$: intersections $2-x^2=-x\Rightarrow x=-1,2$.
  $A=\int_{-1}^2(2+x-x^2)\,dx=\left[2x+\frac{x^2}2-\frac{x^3}3\right]_{-1}^2=\frac92$

**Steps:** find intersections → decide which curve is on top (test a point) → integrate top − bottom.

## 8. Integration by parts (slides 24–25)
Reverse of the Product Rule:
$$\int f\,g'\,dx=f\,g-\int f'\,g\,dx\qquad(\text{also written }\int u\,dv=uv-\int v\,du)$$
Pick $f$ = something that gets **simpler** when differentiated; $g'$ = something easy to integrate.
- $\int x\cos x\,dx$: $f=x$, $g'=\cos x$ → $x\sin x+\cos x+C$
- $\int\ln x\,dx$: $f=\ln x$, $g'=1$ → $x\ln x-x+C$
- $\int x^2e^xdx$: parts **twice** → $x^2e^x-2xe^x+2e^x+C$

> [!tip] Choosing $f$ (LIATE): **L**og, **I**nverse trig, **A**lgebraic, **T**rig, **E**xponential — the earlier one is usually $f$.

## 9. Trigonometric integrals (slide 26)
- **Odd power of sin:** keep one $\sin x$, turn the rest into $1-\cos^2x$, let $u=\cos x$.
  $\int\sin^3x\,dx=\int(1-\cos^2x)\sin x\,dx=-\cos x+\frac{\cos^3x}3+C$
- **Odd power of cos:** keep one $\cos x$, use $1-\sin^2x$, let $u=\sin x$.
- **Even powers:** half-angle identities $\sin^2x=\frac{1-\cos2x}2$, $\cos^2x=\frac{1+\cos2x}2$:
  $\int\sin^2x\,dx=\frac x2-\frac{\sin2x}4+C$, $\int\cos^2x\,dx=\frac x2+\frac{\sin2x}4+C$
- Key idea: bring the power down until only basic integrals remain.

## 10. Improper integrals
### Type I — infinite limits (slides 27–30)
$\int_a^\infty f=\lim_{b\to\infty}\int_a^bf$ (similarly $-\infty$; for $(-\infty,\infty)$ split at any $c$).
If the limit is finite the integral **converges**, otherwise it **diverges**.
- $\int_1^\infty\frac{dx}{x^2}=\lim(1-\frac1b)=1$ — infinite region, finite area.
- **p-test:**
$$\int_1^\infty\frac{dx}{x^p}=\begin{cases}\frac1{p-1}&p>1\ \text{(converges)}\\ \text{diverges}&p\le1\end{cases}$$
  ($p=1$: $\lim\ln b=\infty$.)

### Type II — integrand blows up inside $[a,b]$ (slides 31–32)
Take a one-sided limit toward the bad point; if it is in the middle, **split** there.
- $\int_0^3\frac{dx}{(x-1)^{2/3}}$ blows up at $x=1$ → left piece $=3$, right piece $=3\sqrt[3]2$ → total $3(1+\sqrt[3]2)$.

> [!warning] Always check for bad points **inside** the interval before using FTC II directly.

---

## 📝 Live lecture notes — 2026-09-14
*Filled in during the lecture: slide number → what the lecturer said, Ethan's questions, extra examples.*

-
