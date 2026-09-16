---
title: Common Mistakes
tags: [calculus-a, practice, mistakes]
updated: 2026-09-16
---

# ⚠️ Common Mistakes

Back to [[00 Index]] · See [[Student Profile]], [[Verification Methods]]

Ethan's own errors from past sessions, each with its fix. Add new ones as they happen.

## Algebra
| Mistake | Fix |
|---|---|
| Dropping the constant in point-slope: $y-3=-2(x-3)\to y=-2x+6$ | Expand fully, then move the constant: $y=-2x+9$ |
| Cancelling a factor that isn't in **every** term, e.g. $\frac{3z(3-z)+(3-z)}{3z}$ | Split the fraction term by term first |
| Isolating $x$ from $x^{3/2}=1$ | Raise both sides to the reciprocal power $2/3$ |
| Leaving double negatives: $-20\cos^{-5}x\cdot(-\sin x)$ | Always simplify the sign at the end |

## Derivatives
| Mistake | Fix |
|---|---|
| $(\cos x)'=\sin x$ | $(\cos x)'=-\sin x$ — "co" functions get a minus |
| Forgetting the inner derivative: $((x^2+1)^3)'=3(x^2+1)^2$ | ×$2x$ — Chain Rule |
| $(e^{-2x})'=e^{-2x}$ | $-2e^{-2x}$ |
| "Multiply masuk" — differentiating again after the Chain Rule | Chain Rule × is ordinary multiplication; then **stop** |
| Treating $x\cos x$ as if only one part changes | Product Rule: $\cos x-x\sin x$ |
| Implicit: $\frac{d}{dx}y^2=2y$ | $2y\frac{dy}{dx}$ |
| Confusing $\frac{dr}{d\theta}$ (unknown) with $\frac{d\theta}{d\theta}$ ($=1$) | Variable w.r.t. itself $=1$; anything else, write the derivative |
| Quotient Rule inside L'Hôpital | L'Hôpital: differentiate top and bottom **separately** |
| Critical points of $\frac{N}{D}$ | $N=0$ where $D\neq0$; also check where $D=0$ inside the domain |
| Skipping the domain with roots/logs | Find the domain **first** |
| Plug-and-play with table values | Write the rule symbolically first, then substitute |

## Integrals (watch in L03)
| Likely mistake | Fix |
|---|---|
| **Reaching for the Chain Rule on a fraction** (Ex 23, 2026-09-16) | Ask *"is there something **inside** something?"* No inner function → split the fraction and use the Power Rule |
| Dividing by a fractional exponent: $\frac{s^{-1/2}}{-1/2}$ read as $-\frac12 s^{-1/2}$ | Dividing by $-\frac12$ = **multiplying by $-2$** → $-2s^{-1/2}$ |
| Leaving $\sqrt{\sqrt2}$ or $\frac{2}{2^{1/4}}$ unsimplified | Convert roots to powers: $\sqrt{\sqrt2}=2^{1/4}$, $\frac{2}{2^{1/4}}=2^{3/4}$ |
| Forgetting $+C$ | Indefinite always gets $+C$; definite never |
| $\int\sin x=\cos x$ | $-\cos x$ (the sign flips the opposite way from derivatives) |
| $\int\sin(ax)$ without dividing by $a$ | $-\frac1a\cos(ax)$ |
| Substitution: keeping old $x$-limits after switching to $u$ | Convert the limits or substitute back, never mix |
| Area between curves as bottom − top | top − bottom; test a point |
| FTC II straight through a blow-up point | Check the interval first → improper integral |

## Meta
- **Not verifying.** Every final answer gets a check → [[Verification Methods]].
- **Not simplifying first.** Trig identities or splitting fractions often make the problem much easier.
- **Picking the technique before looking.** Name *why* a rule applies before using it — see the "inside something?" test above.
