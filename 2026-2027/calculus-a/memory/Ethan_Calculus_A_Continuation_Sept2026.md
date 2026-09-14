---
title: Calculus A Tutoring - Extended Session Handover
date: September 14, 2026
student: Ethan
institution: University of Twente
course: Calculus A (Lecture 2: Differentiation & Applications)
session_focus: Exercises 23-70+ (Derivatives, Implicit Differentiation, Extrema, L'Hôpital, Antiderivatives)
---

# 📚 SESSION OVERVIEW

This extended session covered **Lecture 2 exercises (problems 23-70+)** with heavy focus on:
- Multi-layer Chain Rule applications
- Product Rule + Chain Rule combinations
- Implicit differentiation with Chain Rule
- Finding absolute & local extrema (increasing/decreasing intervals)
- L'Hôpital's Rule (single & double application)
- Antiderivatives & Indefinite Integrals

---

# ✅ EXERCISES COVERED

## Derivative Rules Practice (Exercises 23-50)

### Problems Worked:
- **Ex 23:** p = √(3 - t) → dp/dt = -1/(2√(3-t)) ✓
- **Ex 36:** y = (1 + 2x)e^(-2x) → dy/dx = -4xe^(-2x) ✓ (Product + Chain Rule)
- **Ex 62:** y = cos(5sin(t/3)) → dy/dt = -(5/3)sin(5sin(t/3))cos(t/3) ✓ (Double Chain Rule)

### Key Breakthroughs:
1. **Multi-layer Chain Rule**: Understanding that -sin(5sin(t/3)) is NOT the final answer—must multiply by du/dt
2. **Product Rule in e^x context**: d/dx[e^(-2x)] = -2e^(-2x), not just e^(-2x)
3. **"Multiply masuk" misconception resolved**: Chain Rule multiply means algebra multiply (×), NOT apply derivative again

---

## Implicit Differentiation (Exercises 1-20)

### Problems Worked:
- **Ex 7:** y² = (x-1)/(x+1) → dy/dx = 1/[y(x+1)²] ✓
- **Ex 19:** sin(rθ) = 1/2 → dr/dθ = -r/θ ✓ (Product Rule in implicit context)

### Critical Concept Clarified:
**Why dr/dθ vs dθ/dθ:**
- dr/dθ: r is function of θ (unknown, write it out)
- dθ/dθ: θ is independent variable (= 1)
- Student now understands: ANY time you see variable with itself = 1; ANY time function not obviously known = write the derivative notation

---

## Table-Based Derivative Problems (Exercise 88)

### Problems Worked:
All 7 parts (a-g) with given values at x=0 and x=1:
- **a.** 5f(x) - g(x) at x=1 → 5f'(1) - g'(1) = 1 ✓
- **b.** f(x)g³(x) at x=0 → 5 + 1 = 6 ✓ (Product + Chain Rule)
- **c.** f(x)/(g(x)+1) at x=1 → 1 ✓ (Quotient Rule)
- **d.** f(g(x)) at x=0 → -1/9 ✓ (Chain Rule)
- **e.** g(f(x)) at x=0 → -40/3 ✓ (Chain Rule, reversed)
- **f.** (x¹¹ + f(x))⁻² at x=1 → -1/3 ✓
- **g.** f(x + g(x)) at x=0 → -4/9 ✓

**Important lesson**: Always write RULE FIRST, then substitute values. Don't plug-and-play.

---

## Inverse Function Derivatives (Exercise 9)

### Problem:
f(2) = 4, f'(2) = 1/3 → Find df⁻¹/dx at x=4
- Formula: (f⁻¹)'(x) = 1/f'(f⁻¹(x))
- f⁻¹(4) = 2 (because f(2)=4)
- Answer: 1/f'(2) = 1/(1/3) = **3** ✓

---

## Logarithmic & Inverse Trig Derivatives (Exercises 21-40)

### Problems Worked:
- **Ex 21:** y = t(ln t)² → dy/dt = (ln t)² + 2ln t ✓ (Product + Chain Rule)
- **Ex (unlabeled):** y = ln(x)/(1 + ln x) → dy/dx = 1/[x(1 + ln x)²] ✓ (Quotient Rule)
- **Ex 34:** y = tan⁻¹(ln x) → dy/dx = 1/[x(1 + (ln x)²)] ✓ (Inverse Trig + Chain Rule)

### Formula Reminder:
- d/dx[tan⁻¹(u)] = 1/(1 + u²) · du/dx

---

## Finding Extrema (Exercises 39, 60, 64)

### Problems Worked:

**Ex 39: f(x) = 1/x + ln x on [0.5, 4]**
- f'(x) = (x-1)/x²
- Critical point: x = 1
- f(0.5) ≈ 1.307, f(1) = 1 **(MIN)**, f(4) ≈ 1.636 **(MAX)**
- Key lesson: Check penyebut ≠ 0 (x ≠ 0 here)

**Ex 60: y = √(3 + 2x - x²)**
- Domain: [-1, 3] (from 3 + 2x - x² ≥ 0)
- dy/dx = (1-x)/√(3 + 2x - x²)
- Critical point: x = 1
- Absolute Max: (1, 2); Absolute Mins: (-1, 0) and (3, 0)

**Ex 64: y = e^x - e^(-x)**
- dy/dx = e^x + e^(-x) > 0 ALWAYS
- **NO extrema!** (Always increasing)
- Lesson: Not all functions have max/min

### Critical Point Rule Clarified:
For (pembilang)/(penyebut) = 0:
- Set pembilang = 0
- Check that penyebut ≠ 0 at those x values
- Only pembilang zeros count as critical points (if penyebut ≠ 0)

---

## Increasing/Decreasing Intervals & Extrema (Exercises 32-33)

### Ex 32: g(x) = 4√x - x² + 3

| Property | Result |
|----------|--------|
| Domain | [0, ∞) |
| g'(x) | 2/√x - 2x |
| Critical points | x = 1 |
| Increasing | (0, 1) |
| Decreasing | (1, ∞) |
| Local Max | (1, 6) |

### Ex 33: g(x) = x√(8 - x²)

| Property | Result |
|----------|--------|
| Domain | [-2√2, 2√2] |
| g'(x) | (8 - 2x²)/√(8 - x²) |
| Critical points | x = ±2 |
| Increasing | (-2, 2) |
| Decreasing | (-2√2, -2) ∪ (2, 2√2) |
| Local Min | (-2, -4) |
| Local Max | (2, 4) |

**Key template for these problems:**
1. Find domain (especially important with roots!)
2. Find dy/dx
3. Find critical points (check penyebut!)
4. Sign chart (test values in each interval)
5. Identify intervals & extrema

---

## L'Hôpital's Rule (Exercises 17, 48)

### Ex 17: lim(θ→π/2) [2θ - π]/[2cos(2π - θ)]

**Process:**
1. Check: 0/0? Yes ✓
2. Turun: d/dθ[2θ - π] = 2, d/dθ[2cos(2π - θ)] = 2sin(2π - θ)
3. Apply: lim = 2/[2sin(3π/2)] = 2/(-2) = **-1** ✓

### Ex 48: lim(x→0) (e^x - 1)²/(x sin x)

**Process:**
1. Check: 0/0? Yes ✓
2. First L'Hôpital: 2(e^x - 1)e^x / (sin x + x cos x)
3. Check: Still 0/0? Yes ✓
4. Second L'Hôpital: 2e^x(2e^x - 1) / (2cos x - x sin x)
5. Evaluate: 2·1·(2-1) / (2·1 - 0) = 2/2 = **1** ✓

**Key reminder:**
- ⚠️ Turunkan pembilang & penyebut TERPISAH (not Quotient Rule!)
- May need to apply multiple times (check 0/0 each time)

---

## Antiderivatives & Indefinite Integrals (Exercises 13, 25)

### Problems Worked:

**Ex 13.a:** ∫(-π sin πx) dx = cos(πx) + C ✓

**Ex 13.b:** ∫(3 sin x) dx = -3 cos x + C ✓

**Ex 13.c:** ∫(sin πx - 3 sin 3x) dx = -(1/π)cos(πx) + cos(3x) + C ✓

**Ex 25:** ∫(x + 1) dx = x²/2 + x + C ✓

**Key pattern with coefficients:**
- ∫sin(ax) dx = -(1/a)cos(ax) + C
- ∫cos(ax) dx = (1/a)sin(ax) + C
- ∫e^(ax) dx = (1/a)e^(ax) + C
- (Divide by the coefficient inside!)

---

# 🧠 MAJOR CONCEPT FIXES

## 1. "Multiply Masuk" Misconception
**Error:** Student tried to "multiply inside" Chain Rule results, causing double-differentiation
**Fix:** Emphasized that Chain Rule × means arithmetic multiplication, then STOP. No more derivatives.
**Example:** -sin(5sin(t/3)) times (5/3)cos(t/3) = -(5/3)sin(5sin(t/3))cos(t/3), not more turunan

## 2. Critical Points with Fractions
**Error:** Student didn't understand why penyebut ≠ 0
**Fix:** Clarified: pembilang=0 gives potential critical points, BUT penyebut must not be 0 (else undefined, not 0)
**Rule:** Only pembilang zeros count (if penyebut ≠ 0 at those points)

## 3. Implicit Differentiation Variables
**Error:** Confusion between dr/dθ (unknown) vs dθ/dθ (=1)
**Fix:** Explained: any d[variable]/d[same variable] = 1; any d[function]/d[variable] = write it out
**Applied to:** Product Rule in d/dθ[rθ], showing θ(dr/dθ) + r

## 4. Exponent Arithmetic
**Error:** From x^(3/2) = 1, didn't know how to isolate x
**Fix:** Taught raising both sides to reciprocal power: [x^(3/2)]^(2/3) = x^1 = x

## 5. L'Hôpital Mechanics
**Error:** Initially tried Quotient Rule instead of separating pembilang & penyebut
**Fix:** Emphasized: turun TERPISAH, bukan pakai Quotient Rule!

---

# 🎯 COMMON ERRORS TO WATCH

1. **Chain Rule with e^(-ax):** Must include the -a in the answer
2. **Multi-layer Chain Rule:** Don't "multiply inside"—just multiply algebrically at end
3. **Implicit d/dx[y²]:** Must be 2y·dy/dx (students often forget dy/dx)
4. **Quotient Rule vs L'Hôpital:** L'Hôpital = turun terpisah, NOT Quotient Rule
5. **Critical points with fractions:** ALWAYS check penyebut ≠ 0
6. **Domain with roots:** Must find domain FIRST before proceeding
7. **Antiderivative constants:** Always +C at the end!
8. **Simplification before rules:** Sometimes simplify FIRST (e.g., trig identities, fractions)

---

# 📊 VERIFICATION METHODS PRACTICED

Student is **highly proficient** with:
1. **Numerical checks** (h ≈ 0.0001 for limit definition)
2. **Special value substitution** (x = 0, x = 1, etc.)
3. **Differentiation check for antiderivatives** (d/dx[answer] should give original)
4. **Simplification verification** (checking that cancellations work)

---

# 💡 LEARNING STYLE RECAP

✅ **Works best with:**
- Very detailed step-by-step breakdown
- "Why" explanation at each step (not just "how")
- Analogies and multiple examples
- Numerical verification before "trusting" algebra
- Indonesian explanations for dense concepts
- Explicit naming of rules/concepts (not just implicit)

❌ **Struggles with:**
- Skipping steps
- Assuming prior knowledge
- Abstract explanations without examples
- Incomplete algebraic simplification (wants to see intermediate steps)

---

# 🎓 STUDENT STRENGTHS

1. **Asks clarifying questions** — identifies gaps and asks for re-explanation
2. **Verification mindset** — wants to check answers with multiple methods
3. **Pattern recognition** — caught mistakes in my explanations (e.g., "kok jadi x?" about exponents)
4. **Honest about confusion** — doesn't pretend to understand when lost
5. **Catches own errors** — when shown numerical checks, identifies where algebra went wrong

---

# ⚠️ AREAS FOR CONTINUED FOCUS

1. **Algebra simplification** — especially fractions with products/sums
2. **Trig derivative signs** — still needs reminding about minus signs
3. **Multi-layer composition recognition** — identifying inner vs outer quickly
4. **Domain consciousness** — remembering to check domain FIRST with roots/logs
5. **Antiderivative pattern recognition** — connecting derivative formulas to antiderivative formulas

---

# 🎯 RECOMMENDED NEXT STEPS

### Immediate (If student returns soon):
- More antiderivative practice (exercises 25-70)
- **Definite integrals** (if moving to Lecture 3)
- Practice 5-10 more extrema problems (build fluency)
- Optional: Curve sketching (using 1st & 2nd derivatives)

### Medium-term:
- **Related rates problems** (application of implicit differentiation)
- **Optimization problems** (maximize/minimize word problems)
- **Second derivative test** (for local extrema)
- **Concavity & inflection points** (f''(x) analysis)

### Study Approach:
- Continue with **bilingual support** (Indonesian for hard concepts)
- Maintain **verification habit** (numerical + algebraic)
- Use **worked examples** (3-5 per new concept)
- Keep requesting **step-by-step detail** (this works!)

---

# 📚 QUICK REFERENCE: KEY FORMULAS

## Differentiation Rules (Comprehensive)

| Rule | Formula | Notes |
|------|---------|-------|
| Power | d/dx[xⁿ] = nxⁿ⁻¹ | Most fundamental |
| Constant Multiple | d/dx[cf(x)] = cf'(x) | Scalar through |
| Sum/Difference | d/dx[u ± v] = u' ± v' | Term-by-term |
| Product | (uv)' = u'v + uv' | Both parts matter |
| Quotient | (u/v)' = (u'v - uv')/v² | **MINUS sign** |
| Chain | d/dx[f(g(x))] = f'(g(x))·g'(x) | Outer × Inner |
| **Trigonometric** | | |
| sin(x) | cos(x) | |
| cos(x) | **-sin(x)** | Minus! |
| tan(x) | sec²(x) | |
| **Exponential/Log** | | |
| e^x | e^x | Self-replicating |
| a^x | a^x·ln(a) | |
| ln(x) | 1/x | |
| **Inverse Trig** | | |
| tan⁻¹(u) | 1/(1+u²) · u' | Must multiply du/dx |

## Antiderivative Rules

| f(x) | ∫f(x)dx | Notes |
|------|---------|-------|
| x^n | x^(n+1)/(n+1) + C | n ≠ -1 |
| sin(x) | -cos(x) + C | Note minus |
| cos(x) | sin(x) + C | |
| e^x | e^x + C | |
| 1/x | ln\|x\| + C | Absolute value |
| sin(ax) | -(1/a)cos(ax) + C | Divide by a |
| cos(ax) | (1/a)sin(ax) + C | Divide by a |

---

# 📞 SESSION STATISTICS

- **Problems worked:** 30+
- **Major concepts clarified:** 5
- **Student-identified errors:** 8
- **Verification methods used:** 50+
- **Breakthroughs:** Multi-layer Chain Rule, implicit diff with Product Rule, critical points with fractions
- **Confidence level:** Medium-High (ready for next exercises, some hesitation on multi-layer compositions)

---

# 🎓 FINAL ASSESSMENT

## Strengths
- ✅ Excellent at following logical steps
- ✅ Strong verification mindset
- ✅ Good at catching mistakes when shown numerically
- ✅ Understands concept of derivatives deeply
- ✅ Rules becoming automatic (Product, Quotient, Chain)

## Areas for Growth
- ⚠️ Speed of pattern recognition (which rule applies?)
- ⚠️ Algebraic simplification comfort level
- ⚠️ Multi-layer composition (still needs to slow down & identify layers)
- ⚠️ Antiderivative formula memorization (inverse of derivatives, but pattern not yet automatic)

## Overall Progress
**SIGNIFICANT** — Ethan has mastered all major Lecture 2 concepts and can apply them in combination. Ready for next lecture material or optimization/related rates applications.

---

**Document Prepared:** September 14, 2026  
**Session Duration:** Extended (6+ hours of tutoring)  
**Prepared by:** Claude (Web Chat)  
**For:** Next Claude Agent  
**Student:** Ethan @ University of Twente  
**Course:** Calculus A (Lecture 2 consolidation + extension)

---

## Next Agent Notes

Ethan responds best to:
1. **"Why" at every step** — don't skip reasoning
2. **Multiple examples** — one example won't stick
3. **Numerical verification** — he trusts numbers over pure algebra
4. **Indonesian for hard concepts** — use it liberally
5. **Explicit rule naming** — "This is Chain Rule" not just "now we..."
6. **Slow downs on multi-layer** — let him identify layers himself before solving

He WILL ask follow-up questions if lost—this is good, lean into it!

---

**END OF HANDOVER DOCUMENT**
