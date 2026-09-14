---
title: "Lecture 2 — Differentiation"
lecture: 2
date: 2026-09-07
slides: ../../lectures_slides/lecture_2.pdf
tags: [calculus-a, lecture, derivatives]
status: done
---

# Lecture 2 — Differentiation of Single-Variable Functions

Back to [[00 Index]] · Prev: [[L01 Functions Limits Continuity]] · Next: [[L03 Integration]]
Formula sheet: [[Derivative Rules]] · Practice: [[Exercise Log#Lecture 2]]

## Tangent lines and the derivative (slides 2–4)
- **Secant slope** between $x_0$ and $x_0+h$: $\frac{f(x_0+h)-f(x_0)}{h}$. Let $h\to0$ → the **tangent slope**.
$$f'(x_0)=\lim_{h\to0}\frac{f(x_0+h)-f(x_0)}{h}$$
- Equivalent form: $f'(x)=\lim_{z\to x}\frac{f(z)-f(x)}{z-x}$.
- Notation: $f'(x)=\frac{dy}{dx}=y'$ — all the same thing.
- Example: $f(x)=\frac1x$ → slope at $a$ is $-\frac1{a^2}$; at $a=-1$ slope is $-1$.
- Derivative of a constant is $0$.
- **Tangent line:** $y=f'(x_0)(x-x_0)+f(x_0)$.

## Rules (slides 5–9)
| Rule | Formula | Slide example |
|---|---|---|
| Power | $(x^n)'=nx^{n-1}$ (any real $n$) | $(\sqrt x)'=\frac1{2\sqrt x}$ |
| Sum | $(u+v)'=u'+v'$ | $(x^3+x^{(2+\pi)/2})'$ |
| Product | $(uv)'=u'v+uv'$ | $\left(\frac1x(x^2+e^x)\right)'=1+\frac{e^x(x-1)}{x^2}$ |
| Quotient | $\left(\frac uv\right)'=\frac{u'v-uv'}{v^2}$ | $\left(\frac{x^2-1}{x^3+1}\right)'=\frac{-x^4+3x^2+2x}{(x^3+1)^2}$ |

**The number $e$:** $e=\lim_{n\to\infty}(1+\frac1n)^n\approx2.71828$, and $(e^x)'=e^x$ because $\lim_{h\to0}\frac{e^h-1}{h}=1$.

## Trigonometric derivatives (slides 10–11)
$(\sin x)'=\cos x$, $(\cos x)'=-\sin x$, $(\tan x)'=\sec^2x$, $(\cot x)'=-\csc^2x$, $(\sec x)'=\sec x\tan x$, $(\csc x)'=-\csc x\cot x$.
> [!warning] All the "co-" functions (cos, cot, csc) get a **minus** sign.

## Chain Rule (slides 12–13)
$$(f\circ g)'(x)=f'(g(x))\cdot g'(x)\qquad\frac{dy}{dx}=\frac{dy}{du}\cdot\frac{du}{dx}$$
- "Derivative of the outside (inside left alone) × derivative of the inside."
- Example: $\frac{d}{dx}\sin(x^2+e^x)=\cos(x^2+e^x)\cdot(2x+e^x)$.

## Implicit differentiation (slides 14–15)
When $y$ is only given by an equation $F(x,y)=0$:
1. Differentiate both sides w.r.t. $x$, treating $y$ as $y(x)$ → every $y$-term gets a $\frac{dy}{dx}$ (Chain Rule).
2. Collect $\frac{dy}{dx}$ terms and solve.
- $x^2+y^2=25 \Rightarrow 2x+2y\,y'=0 \Rightarrow y'=-\frac xy$.

## Inverse functions (slides 16–20)
$$\left(f^{-1}\right)'(b)=\frac{1}{f'\!\left(f^{-1}(b)\right)}$$
Derived by differentiating $f(f^{-1}(x))=x$ with the Chain Rule.
- $f=x^2$ ($x\ge0$), $f^{-1}=\sqrt x$: $\frac{1}{2\sqrt x}$ ✓
- $\ln x$ is the inverse of $e^x$ → $(\ln x)'=\frac1{e^{\ln x}}=\frac1x$; also $(\ln\lvert x\rvert)'=\frac1x$.
- Log laws: $\ln(xy)=\ln x+\ln y$, $\ln\frac xy=\ln x-\ln y$, $\ln x^r=r\ln x$.
- $\arctan$: from $\tan y=x$, $\sec^2y\,y'=1$, $\sec^2y=1+\tan^2y=1+x^2$ → $(\tan^{-1}x)'=\frac1{1+x^2}$.

| $f$ | Domain | Range | $f'$ |
|---|---|---|---|
| $\sin^{-1}x$ | $[-1,1]$ | $[-\frac\pi2,\frac\pi2]$ | $\frac1{\sqrt{1-x^2}}$ |
| $\cos^{-1}x$ | $[-1,1]$ | $[0,\pi]$ | $-\frac1{\sqrt{1-x^2}}$ |
| $\tan^{-1}x$ | $\mathbb R$ | $(-\frac\pi2,\frac\pi2)$ | $\frac1{1+x^2}$ |
| $\cot^{-1}x$ | $\mathbb R$ | $(0,\pi)$ | $-\frac1{1+x^2}$ |
| $\sec^{-1}x$ | $\lvert x\rvert\ge1$ | $[0,\pi]$, $y\ne\frac\pi2$ | $\frac1{\lvert x\rvert\sqrt{x^2-1}}$ |
| $\csc^{-1}x$ | $\lvert x\rvert\ge1$ | $[-\frac\pi2,\frac\pi2]$, $y\ne0$ | $-\frac1{\lvert x\rvert\sqrt{x^2-1}}$ |

## Extreme values (slides 21–28)
- **Absolute max/min** on $D$: largest/smallest value on all of $D$. **Local**: largest/smallest nearby.
- **Extreme Value Theorem:** $f$ continuous on closed $[a,b]$ ⇒ absolute max and min both exist.
- **First Derivative Theorem:** local extremum at interior $c$ and $f'(c)$ exists ⇒ $f'(c)=0$.
- **Critical point:** interior point where $f'=0$ **or $f'$ undefined**.

**Absolute extrema on $[a,b]$:** evaluate $f$ at critical points and endpoints → biggest = max, smallest = min.
- $f=10x(2-\ln x)$ on $[1,e^2]$: $f'=10(1-\ln x)=0\Rightarrow x=e$. $f(1)=20$, $f(e)=10e\approx27.2$ (**max**), $f(e^2)=0$ (**min**).

**Monotonicity:** $f'>0$ on $(a,b)$ ⇒ increasing; $f'<0$ ⇒ decreasing.

**First Derivative Test** at critical $c$: $f'$ goes $-\to+$ ⇒ local min; $+\to-$ ⇒ local max; no sign change ⇒ no extremum.
- $f=x^{1/3}(x-4)$: $f'=\frac{4(x-1)}{3x^{2/3}}$, critical at $x=0$ (undefined) and $x=1$. Signs: $-,-,+$ → **no extremum at 0**, local & absolute min $f(1)=-3$.

## L'Hôpital's Rule (slides 29–32)
If the limit is of form $\frac00$ or $\frac\infty\infty$:
$$\lim_{x\to a}\frac{f(x)}{g(x)}=\lim_{x\to a}\frac{f'(x)}{g'(x)}$$
- Differentiate top and bottom **separately** — not the Quotient Rule.
- Repeat while still indeterminate. **Don't** apply if either part has a finite nonzero limit.
- $\lim_{x\to0}\frac{3x-\sin x}{x}=2$; $\lim_{x\to0}\frac{x-\sin x}{x^3}=\frac16$ (three times); $\lim_{x\to\infty}\frac{\ln x}{2\sqrt x}=0$.

## Antiderivatives (slides 33–34)
- $F$ is an antiderivative of $f$ if $F'=f$. General antiderivative: $F(x)+C$.
- Example: $f=3x^2$ with $F(1)=-1$ → $F=x^3+C$, $1+C=-1$, so $F=x^3-2$.
- Continued in [[L03 Integration]].

## Topics not in the slides but still to practise
Higher-order derivatives & concavity, related rates, optimization word problems, second-derivative test.
