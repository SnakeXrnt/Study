---
title: Verification Methods
tags: [calculus-a, reference, checking]
updated: 2026-09-14
---

# ✅ Verification Methods

Back to [[00 Index]] · Used in [[Teaching Playbook]]

Ethan trusts numbers over pure algebra, so **every final answer gets at least one check.**

## For derivatives
1. **Numerical difference quotient** (most reliable)
   $f'(a)\approx\frac{f(a+h)-f(a)}{h}$ with $h=0.0001$; compare with the formula.
2. **Special values** — plug $x=0$, $x=1$ into the original and the simplified form; they must agree.
   *Example:* $w=-2z+6$ vs $w=\frac1z+\frac83-z$ at $z=1$ gives $4$ vs $\frac83$, so one is wrong.
3. **Re-derive another way** — simplify first, then differentiate, and compare.
4. **Graph** (Desmos/GeoGebra) — does the slope sign match where $f$ rises or falls?
5. **Sanity** — sign, size, units.

## For integrals
1. **Differentiate the answer** → must give the integrand back.
2. **Numerical estimate** — a Riemann sum with a few rectangles should land near a definite integral.
3. **Geometry** — compare with a known shape (triangle, rectangle); area must be $\ge 0$.
4. **Bounds** — $\min f\cdot(b-a)\le\int_a^bf\le\max f\cdot(b-a)$.

## For limits
- Plug in values close to the point from both sides (e.g. $x=0.01$, $-0.01$).
