---
title: Derivative Rules
tags: [calculus-a, reference, derivatives]
updated: 2026-09-14
---

# 📐 Derivative Rules

Back to [[00 Index]] · Theory: [[L02 Differentiation]] · Integrals: [[Integration Rules]]

## Definition
$$f'(x)=\lim_{h\to0}\frac{f(x+h)-f(x)}{h}=\lim_{z\to x}\frac{f(z)-f(x)}{z-x}$$
Tangent at $x_0$: $y=f(x_0)+f'(x_0)(x-x_0)$

## Core rules
| Rule | Formula | Remember |
|---|---|---|
| Constant | $(c)'=0$ | |
| Power | $(x^n)'=nx^{n-1}$ | any real $n$ |
| Constant multiple | $(cf)'=cf'$ | |
| Sum | $(u\pm v)'=u'\pm v'$ | term by term |
| Product | $(uv)'=u'v+uv'$ | both parts change |
| Quotient | $\left(\frac uv\right)'=\frac{u'v-uv'}{v^2}$ | **minus**, "low d-high minus high d-low" |
| Chain | $f(g(x))'=f'(g(x))\,g'(x)$ | outside × inside |
| Inverse | $(f^{-1})'(b)=\frac1{f'(f^{-1}(b))}$ | |

## Exponential & log
| $f$ | $f'$ |
|---|---|
| $e^x$ | $e^x$ |
| $a^x$ | $a^x\ln a$ |
| $\ln x$ (and $\ln\lvert x\rvert$) | $\frac1x$ |
| $\log_ax$ | $\frac1{x\ln a}$ |
| $\ln u$ | $\frac{u'}{u}$ |

## Trig
| $f$ | $f'$ |
|---|---|
| $\sin x$ | $\cos x$ |
| $\cos x$ | $-\sin x$ |
| $\tan x$ | $\sec^2x$ |
| $\cot x$ | $-\csc^2x$ |
| $\sec x$ | $\sec x\tan x$ |
| $\csc x$ | $-\csc x\cot x$ |

## Inverse trig
| $f$ | $f'$ |
|---|---|
| $\sin^{-1}x$ | $\frac1{\sqrt{1-x^2}}$ |
| $\cos^{-1}x$ | $-\frac1{\sqrt{1-x^2}}$ |
| $\tan^{-1}x$ | $\frac1{1+x^2}$ |
| $\cot^{-1}x$ | $-\frac1{1+x^2}$ |
| $\sec^{-1}x$ | $\frac1{\lvert x\rvert\sqrt{x^2-1}}$ |
| $\csc^{-1}x$ | $-\frac1{\lvert x\rvert\sqrt{x^2-1}}$ |
With the Chain Rule, multiply by $u'$: e.g. $(\tan^{-1}u)'=\frac{u'}{1+u^2}$.

## Techniques
- **Implicit:** differentiate both sides; each $y$-term gets $\frac{dy}{dx}$; solve for it.
- **L'Hôpital** ($\frac00$ or $\frac\infty\infty$ only): $\lim\frac fg=\lim\frac{f'}{g'}$ — top and bottom separately.
- **Critical points:** $f'=0$ or $f'$ undefined (interior). For $f'=\frac{N}{D}$: zeros of $N$ where $D\neq0$, plus zeros of $D$ inside the domain.
- **Closed interval extrema:** compare $f$ at critical points + endpoints.
- **Sign chart:** $f'>0$ increasing, $f'<0$ decreasing; $-\to+$ min, $+\to-$ max.

## Useful identities
$\sin^2x+\cos^2x=1$ · $1+\tan^2x=\sec^2x$ · $\sin2x=2\sin x\cos x$ · $\cos2x=\cos^2x-\sin^2x$
