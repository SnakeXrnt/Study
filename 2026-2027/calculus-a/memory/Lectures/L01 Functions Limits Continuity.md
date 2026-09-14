---
title: "Lecture 1 — Functions, Limits, Continuity"
lecture: 1
date: 2026-09-01
slides: ../../lectures_slides/lecture_1.pdf
tags: [calculus-a, lecture, limits, continuity]
status: done
---

# Lecture 1 — Functions, Limits & Continuity

Back to [[00 Index]] · Next: [[L02 Differentiation]]

## 1. Functions (slides 2–7)
- A **function** $f: D \to Y$ assigns **exactly one** output $f(x)$ to each input $x \in D$.
- **Domain** $D$ = allowed inputs. **Range** = outputs actually reached.

| Function | Domain | Range |
|---|---|---|
| $x^2$ | $(-\infty,\infty)$ | $[0,\infty)$ |
| $1/x$ | $x \neq 0$ | $y \neq 0$ |
| $\sqrt{x}$ | $[0,\infty)$ | $[0,\infty)$ |

- **Combining:** domain of $f\pm g$, $fg$ is $D(f)\cap D(g)$; for $f/g$ also remove points where $g=0$.
  - Example: $f=\sqrt x$, $g=\sqrt{1-x}$ → $f+g$ on $[0,1]$, $f/g$ on $[0,1)$, $g/f$ on $(0,1]$.
- **Composition:** $(f\circ g)(x) = f(g(x))$ — apply $g$ first. Domain: $x$ in $D(g)$ with $g(x)\in D(f)$.
  - $f=\sqrt x$, $g=x+1$: $f\circ g=\sqrt{x+1}$, $g\circ f=\sqrt x+1$, $f\circ f=x^{1/4}$, $g\circ g=x+2$.

> [!tip] Why it matters
> Composition is the skeleton of the **Chain Rule** in [[L02 Differentiation]] and of **substitution** in [[L03 Integration]].

## 2. Limits (slides 8–11)
$\lim_{x\to c} f(x) = L$: as $x$ gets close to $c$, $f(x)$ gets close to $L$. **$f(c)$ itself does not matter.**

- Hole example: $\frac{x^2-1}{x-1} = x+1$ for $x\neq1$ → limit at 1 is $2$, even though $f(1)$ is undefined.

**Limit laws** (if $\lim f = L$, $\lim g = M$): sum, difference, constant multiple, product $LM$, quotient $L/M$ ($M\ne0$), power $L^n$, root $L^{1/n}$.

**Techniques for 0/0:**
1. **Factor and cancel:** $\lim_{x\to1}\frac{x^2+x-2}{x^2-x}=\lim\frac{(x-1)(x+2)}{x(x-1)}=3$
2. **Multiply by the conjugate:** $\lim_{x\to0}\frac{\sqrt{x^2+100}-10}{x^2}=\lim\frac{1}{\sqrt{x^2+100}+10}=\frac1{20}$
3. Plain substitution when nothing breaks: $\lim_{x\to-2}(4x^2-3)=13$

## 3. One-sided limits (slides 12–14)
- $\lim_{x\to c^+}$ approach from the right ($x>c$); $\lim_{x\to c^-}$ from the left.
- Example: $f(x)=\frac{\lvert x\rvert}{x}$ → right limit $1$, left limit $-1$ → **two-sided limit does not exist**.

> [!important] Theorem
> $\lim_{x\to c}f(x)=L \iff \lim_{x\to c^-}f(x)=L$ **and** $\lim_{x\to c^+}f(x)=L$.

## 4. Continuity (slides 15–22)
Intuition: draw the graph without lifting the pencil.

**Continuity test** at interior point $c$ — all three must hold:
1. $f(c)$ exists
2. $\lim_{x\to c}f(x)$ exists
3. $\lim_{x\to c}f(x)=f(c)$

At endpoints use the one-sided limit.

- Sums, differences, multiples, products, quotients ($g(c)\neq0$), powers, roots of continuous functions are continuous.
- **Continuous everywhere:** polynomials, $e^x$, $a^x$, $\sin$, $\cos$, $\arctan$.
- **Continuous on domain:** rational functions (where denominator $\neq 0$), $\ln x$ ($x>0$), $\sqrt[n]{x}$, $\tan,\sec$ ($x\ne\frac\pi2+k\pi$), $\cot,\csc$ ($x\ne k\pi$), $\arcsin,\arccos$ on $[-1,1]$.
- **Composition:** if $g$ continuous at $b=\lim f$, then $\lim g(f(x)) = g(\lim f(x))$ → you may move the limit inside.
  - $\lim_{x\to\pi/2}\cos\!\left(2x+\sin(\tfrac{3\pi}{2}+x)\right)=\cos(\pi+0)=-1$
- Example: $y=\sqrt{x^2-2x-5}$ is continuous where $x^2-2x-5\ge0$: $(-\infty,1-\sqrt6]\cup[1+\sqrt6,\infty)$.

**Continuous extension:** if $f$ has a hole at $c$ but the limit exists, define $F(c)=\lim_{x\to c}f(x)$.
- $f(x)=\frac{\sqrt{x+1}-1}{x}=\frac{1}{\sqrt{x+1}+1}$ → set $F(0)=\frac12$.

## 5. Limits at infinity (slides 23–26)
- Describe end-behaviour / **horizontal asymptotes**. $\lim_{x\to\pm\infty}\frac1x=0$.
- Trick from slides: substitute $t=1/x$; $x\to\infty$ becomes $t\to0^+$.
- Conjugate trick: $\lim_{x\to\infty}\left(x-\sqrt{x^2+16}\right)=\lim\frac{-16}{x+\sqrt{x^2+16}}=0$.

## 6. Infinite limits (slides 27–28)
- $\lim f=+\infty$ means $f$ grows without bound (the limit does not exist as a number).
- **Vertical asymptote** $x=a$ if either one-sided limit is $\pm\infty$.
  - $\frac1{x^2}$: both sides $\to+\infty$ at 0.
  - $\frac{1}{x-1}$: $+\infty$ from the right, $-\infty$ from the left at 1.

## Links forward
- Limit definition of the derivative → [[L02 Differentiation]]
- L'Hôpital replaces many 0/0 tricks → [[L02 Differentiation#L'Hôpital's Rule]]
- Improper integrals use limits at infinity → [[L03 Integration#Improper integrals]]
