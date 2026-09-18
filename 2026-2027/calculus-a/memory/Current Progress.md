---
title: Current Progress
tags: [calculus-a, progress]
updated: 2026-09-18
last_device: "Ethan's main laptop"
---

# 📍 Current Progress — continue from here

Back to [[00 Index]] · History: [[Session Log]]

> [!important] For Claude on any device
> Read this file **first**. At the end of each session, **overwrite** it with the latest state (don't append — history goes in [[Session Log]]).

> [!warning] Formatting — read before you answer anything
> Ethan reads the chat in a **terminal**, so `$...$` LaTeX does **not** render and he literally cannot read it.
> In chat, write plain text: `a/b`, `s^(-3/2)`, `sqrt(2)`, `integral from 1 to sqrt(2) of (s^2 + sqrt(s))/s^2 ds`.
> LaTeX is fine (and wanted) **inside these Obsidian notes**. See [[Teaching Playbook]].

> [!important] Explain in "gogo gaga" mode
> Ethan asked for this on **2026-09-18**: explain everything as if he is a complete beginner who has never seen the notation — name the wrong instinct first, restate every formula in plain words, one idea per step, and show the numbers when a variant is wrong. It is the **default** register now. Recipe: [[Teaching Playbook]].

## Last session
- **Date:** 2026-09-16
- **Type:** Lecture 3 practice — definite integrals with FTC II
- **What happened:**
  - **Ex 17** $\int_0^{\pi/8}\sin2x\,dx=\frac{2-\sqrt2}{4}\approx0.1464$ — reverse Chain Rule for $\sin(ax)$.
  - Detoured into the **unit circle** because Ethan didn't know where $\cos0$ and $\cos\frac\pi4$ come from. Derived it from scratch; built an [interactive tool](https://claude.ai/artifact/VL1xCLnf4rfz58ezkdLZeG).
  - **Ex 23** $\int_1^{\sqrt2}\frac{s^2+\sqrt s}{s^2}ds=\sqrt2-2^{3/4}+1\approx0.732421$ — Ethan assumed Chain Rule; the real move is **splitting the fraction** then the Power Rule.
  - Switched all chat output to plain text after Ethan said he couldn't read the LaTeX.

## Where we are now
| Area | Status |
|---|---|
| L01 Functions, limits, continuity | ✅ done |
| L02 Differentiation | ✅ done + 30+ exercises |
| L03 Integration — note from slides | ✅ written |
| L03 live lecture notes | ⬜ **still empty** |
| L03 practice — FTC II | 🟡 started (Ex 17, Ex 23) |
| L03 practice — substitution onwards | ⬜ not started |

**Last exercise worked:** Ex 23, $\int_1^{\sqrt2}\frac{s^2+\sqrt s}{s^2}ds=\sqrt2-2^{3/4}+1$ (see [[Exercise Log]])

**Set for Ethan, not yet answered:** $\int_1^4\frac{x^2+x}{x^{3/2}}dx$ — same split-then-Power-Rule pattern. Ask for his attempt first.

## ▶️ Continue with
1. Check the practice problem above.
2. More FTC II, **deliberately mixed** so Ethan has to choose the technique himself — some with an inner function ($\int\cos3x$, $\int(2x+1)^4$), some fractions to split ($\int\frac{x^3-2x}{x}$).
3. Substitution: indefinite first, then definite with converted limits.
4. Area between curves.
5. Integration by parts (incl. twice), trig integrals.
6. Improper integrals (Type I and II, p-test).
7. **Leftovers from L02:** related rates, optimization, second-derivative test, concavity & inflection points.

## Watch out for (right now)
- **Picking the technique.** Always ask him first: *"is there something **inside** something?"* Yes → reverse Chain Rule. No, it's a fraction → split it, then Power Rule.
- Dividing by a fractional exponent: $\frac{s^{-1/2}}{-1/2}=-2s^{-1/2}$, not $-\frac12 s^{-1/2}$.
- Simplifying nested roots: $\sqrt{\sqrt2}=2^{1/4}$, $\frac2{2^{1/4}}=2^{3/4}$.
- $\int\sin x\,dx=-\cos x$ — the sign.
- Forgetting $+C$ on indefinite integrals; dividing by $a$ in $\int\sin(ax)$.
- Still weak from L02: algebra simplification, spotting inner/outer layers.

## Open questions from Ethan
- *(none open — the $\cos0$ / $\cos\frac\pi4$ question from this session was answered with the unit circle)*
