---
title: Integration Rules
tags: [calculus-a, reference, integration]
updated: 2026-09-16
---

# 📐 Integration Rules

Back to [[00 Index]] · Theory: [[L03 Integration]] · Derivatives: [[Derivative Rules]]

> [!tip] Every antiderivative is a derivative rule read backwards. **Check by differentiating your answer.**

## Basic antiderivatives (add $+C$)
| $f(x)$ | $\int f(x)\,dx$ | Notes |
|---|---|---|
| $k$ | $kx$ | |
| $x^n$ | $\frac{x^{n+1}}{n+1}$ | $n\neq-1$ |
| $\frac1x$ | $\ln\lvert x\rvert$ | the $n=-1$ case |
| $e^x$ | $e^x$ | |
| $a^x$ | $\frac{a^x}{\ln a}$ | |
| $\sin x$ | $-\cos x$ | **minus** |
| $\cos x$ | $\sin x$ | |
| $\sec^2x$ | $\tan x$ | |
| $\csc^2x$ | $-\cot x$ | |
| $\sec x\tan x$ | $\sec x$ | |
| $\csc x\cot x$ | $-\csc x$ | |
| $\frac1{1+x^2}$ | $\tan^{-1}x$ | |
| $\frac1{\sqrt{1-x^2}}$ | $\sin^{-1}x$ | |

## Linear inside ($ax+b$) — divide by $a$
$\int\sin(ax)\,dx=-\frac1a\cos(ax)$ · $\int\cos(ax)\,dx=\frac1a\sin(ax)$ · $\int e^{ax}dx=\frac1ae^{ax}$ · $\int(ax+b)^n dx=\frac{(ax+b)^{n+1}}{a(n+1)}$

## Definite integral rules
$\int_b^a=-\int_a^b$ · $\int_a^a=0$ · $\int kf=k\int f$ · $\int(f\pm g)=\int f\pm\int g$ · $\int_a^b+\int_b^c=\int_a^c$

## Fundamental Theorem
- **FTC I:** $\frac{d}{dx}\int_a^xf(t)dt=f(x)$; with $g(x)$ as upper limit: $f(g(x))\,g'(x)$; if $x$ is in the **lower** limit, flip sign.
- **FTC II:** $\int_a^bf=F(b)-F(a)$.

## Techniques — which one?
> [!tip] Ask first: **is there something *inside* something?**
> If no inner function, don't reach for the Chain Rule/substitution — simplify algebraically first.

| Integrand looks like | Use |
|---|---|
| **Fraction with a single power on the bottom**, e.g. $\frac{s^2+\sqrt s}{s^2}$ | **Split the fraction** term by term, rewrite each as $s^n$, then Power Rule |
| $\sin(ax)$, $(ax+b)^n$, $e^{ax}$ — a *linear* inside | reverse Chain Rule: antiderivative ÷ $a$ |
| Function × derivative of its inside, e.g. $x^2e^{x^3}$ | **Substitution** $u=$ inside |
| Product of unrelated types, e.g. $x\cos x$, $x^2e^x$, $\ln x$ | **By parts** $\int fg'=fg-\int f'g$ (LIATE picks $f$) |
| $\sin^m x\cos^n x$, one power odd | save one factor, Pythagorean identity, substitute |
| $\sin^2x$, $\cos^2x$ (even) | half-angle: $\sin^2x=\frac{1-\cos2x}2$, $\cos^2x=\frac{1+\cos2x}2$ |
| Infinite limit or blow-up inside | **Improper** — write as a limit |

## Splitting a fraction
$$\frac{a+b}{c}=\frac ac+\frac bc \quad\text{(sum on top only — never split a sum on the bottom)}$$
Then use $\sqrt s=s^{1/2}$ and $\frac{s^m}{s^n}=s^{m-n}$ to turn each piece into a single power, e.g.
$$\frac{s^2+\sqrt s}{s^2}=1+s^{-3/2}$$
Power Rule: $\int s^n ds=\frac{s^{n+1}}{n+1}$ — add 1 to the exponent, divide by the new exponent.
⚠️ Dividing by a negative fraction: $\frac{s^{-1/2}}{-1/2}=-2s^{-1/2}$.

## Substitution checklist
1. $u=g(x)$, $du=g'(x)dx$
2. Every $x$ must disappear (solve for $x$ if needed, e.g. $x=\frac{u-1}2$)
3. Definite: convert limits $a\to g(a)$, $b\to g(b)$
4. Indefinite: substitute back to $x$

## Area between curves
$A=\int_a^b(\text{top}-\text{bottom})\,dx$, with $a,b$ at the intersections.

## Improper integrals
- $\int_a^\infty f=\lim_{b\to\infty}\int_a^bf$ · split $(-\infty,\infty)$ at any $c$
- Blow-up at $c$ inside $[a,b]$: split and take one-sided limits
- **p-test:** $\int_1^\infty x^{-p}dx=\frac1{p-1}$ if $p>1$, diverges if $p\le1$

## Sums
$\sum k=\frac{n(n+1)}2$ · $\sum k^2=\frac{n(n+1)(2n+1)}6$ · $\sum k^3=\left(\frac{n(n+1)}2\right)^2$
