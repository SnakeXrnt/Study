---
title: Exercise Log
tags: [calculus-a, practice]
updated: 2026-09-14
---

# ✍️ Exercise Log

Back to [[00 Index]] · Errors: [[Common Mistakes]]

Source for entries before 2026-09-14 (afternoon): the two original handovers. Answers were re-checked when the notes were created.

## Lecture 2
### Limit definition
| Problem | Technique | Answer |
|---|---|---|
| $f=\frac1{x+2}$ via $\lim_{z\to x}$ | common denominator → factor $(z-x)$ | $-\frac1{(x+2)^2}$ |
| $f=x^2-3x+4$ via $\lim_{z\to x}$ | $z^2-x^2=(z-x)(z+x)$ | $2x-3$ |
| Ex 23: $p=\sqrt{3-t}$ | Chain Rule | $-\frac1{2\sqrt{3-t}}$ |

### Tangent lines
| Problem | Answer |
|---|---|
| $f=x^2+1$ at $(2,5)$ | $y=4x-3$ |
| $g=\frac{x}{x-2}$ at $(3,3)$ | slope $-2$, $y=-2x+9$ ⚠️ *handover wrongly listed $\frac16x+\frac53$* |
| $f=\sqrt{x+1}$ at $(8,3)$ | slope $\frac16$, $y=\frac16x+\frac53$ |

### Rules practice
| Problem | Rule(s) | Answer |
|---|---|---|
| $y=x^3e^x$ | Product | $x^2e^x(3+x)$ |
| $r=\frac{e^s}{s}$ | Quotient | $\frac{e^s(s-1)}{s^2}$ |
| $w=\frac{1+3z}{3z}(3-z)$ | simplify: $\frac1z+\frac83-z$ | $-\frac1{z^2}-1$ |
| $p=\frac{\sin q+\cos q}{\cos q}$ | simplify: $\tan q+1$ | $\sec^2q$ |
| $y=\frac{\cos x}{1+\sin x}$ | Quotient + $\sin^2+\cos^2=1$ | $-\frac1{1+\sin x}$ |
| $y=x^2\sin x+2x\cos x-2\sin x$ | Product, cancel | $x^2\cos x$ |
| $y=5\cos^{-4}x$ | Chain | $\frac{20\sin x}{\cos^5x}$ |
| Ex 36: $y=(1+2x)e^{-2x}$ | Product + Chain | $-4xe^{-2x}$ |
| Ex 62: $y=\cos(5\sin\frac t3)$ | double Chain | $-\frac53\sin(5\sin\frac t3)\cos\frac t3$ |
| Horizontal tangents $y=x+2\cos x$ on $[0,2\pi]$ | $y'=0$ | $(\frac\pi6,\frac\pi6+\sqrt3)$, $(\frac{5\pi}6,\frac{5\pi}6-\sqrt3)$ |

### Given values: $u(1)=2,\ u'(1)=0,\ v(1)=5,\ v'(1)=-1$
$(uv)'=-2$ · $(u/v)'=\frac2{25}$ · $(v/u)'=-\frac12$ · $(7v-2u)'=-7$

### Ex 88 (table values, table not saved)
a $=1$ · b $=6$ · c $=1$ · d $=-\frac19$ · e $=-\frac{40}3$ · f $=-\frac13$ · g $=-\frac49$
*Lesson: write the rule first, then substitute.*

### Implicit & inverse
| Problem | Answer |
|---|---|
| $x^2+y^2=25$ | $-\frac xy$ |
| Implicit Ex 7: $y^2=\frac{x-1}{x+1}$ | $\frac1{y(x+1)^2}$ |
| Implicit Ex 19: $\sin(r\theta)=\frac12$ | $\frac{dr}{d\theta}=-\frac r\theta$ |
| Inverse Ex 9: $f(2)=4$, $f'(2)=\frac13$, find $(f^{-1})'(4)$ | $3$ |

### Logs & inverse trig
| Problem | Answer |
|---|---|
| Ex 21: $y=t(\ln t)^2$ | $(\ln t)^2+2\ln t$ |
| $y=\frac{\ln x}{1+\ln x}$ | $\frac1{x(1+\ln x)^2}$ |
| Ex 34: $y=\tan^{-1}(\ln x)$ | $\frac1{x(1+(\ln x)^2)}$ |

### Extrema
| Problem | Result |
|---|---|
| Ex 39: $f=\frac1x+\ln x$ on $[0.5,4]$ | $f'=\frac{x-1}{x^2}$; min $f(1)=1$, max $f(4)\approx1.636$ |
| Ex 60: $y=\sqrt{3+2x-x^2}$ | domain $[-1,3]$; abs max $(1,2)$; abs min $(-1,0)$, $(3,0)$ |
| Ex 64: $y=e^x-e^{-x}$ | $y'>0$ always → no extrema |
| Ex 32: $g=4\sqrt x-x^2+3$ | incr $(0,1)$, decr $(1,\infty)$, local max $(1,6)$ |
| Ex 33: $g=x\sqrt{8-x^2}$ | domain $[-2\sqrt2,2\sqrt2]$; min $(-2,-4)$, max $(2,4)$ |

### L'Hôpital
| Problem | Answer |
|---|---|
| Ex 17: $\lim_{\theta\to\pi/2}\frac{2\theta-\pi}{2\cos(2\pi-\theta)}$ | $-1$ |
| Ex 48: $\lim_{x\to0}\frac{(e^x-1)^2}{x\sin x}$ | $1$ (twice) |

### Antiderivatives
| Problem | Answer |
|---|---|
| Ex 13a: $\int-\pi\sin\pi x\,dx$ | $\cos\pi x+C$ |
| Ex 13b: $\int3\sin x\,dx$ | $-3\cos x+C$ |
| Ex 13c: $\int(\sin\pi x-3\sin3x)dx$ | $-\frac1\pi\cos\pi x+\cos3x+C$ |
| Ex 25: $\int(x+1)dx$ | $\frac{x^2}2+x+C$ |

## Lecture 3
*(none yet)*
