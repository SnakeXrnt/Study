---
title: Verification Methods
tags: [linear-algebra, reference, verification]
updated: 2026-09-15
---

# ✅ Verification Methods

Back to [[00 Index]] · Traps: [[Common Mistakes]]

Linear algebra answers are easy to check — always do it before trusting an answer.

## By hand
| Answer type | Check |
|---|---|
| Unique solution $\mathbf x$ | Plug into **every original** equation (not the reduced ones) |
| Solution set with free variables | Plug in **two** parameter values (e.g. $t=0$ and $t=1$) — both must satisfy all equations. $t=0$ checks $\mathbf p$; the difference checks $\operatorname{Null}A$ |
| "Inconsistent" | Find the combination of original equations that gives $0=c$ |
| RREF | Pivots are 1, zeros above and below each pivot, staircase shape |
| Inverse $A^{-1}$ | Multiply $AA^{-1}$ — must give $I$ (one side is enough, Lemma 2.13) |
| 2×2 inverse | Compare $(A\mid I)$ result with the $\frac1{ad-bc}$ formula |
| Product $AB$ | Size first ($k\times m$ · $m\times n$), then spot-check one entry |
| Elementary matrix $T$ | $TA$ really does the operation |
| $\mathbf w\in\operatorname{Span}$ | Found weights $\alpha_i$: compute $\alpha_1\mathbf v_1+\dots$ and compare |
| Basis of $\operatorname{Null}A$ | $A\mathbf v=\mathbf 0$ for every basis vector; count = number of free variables |
| Determinant | Two different methods (cofactor along a row with zeros vs. triangular reduction) |
| Eigenpair | $A\mathbf v=\lambda\mathbf v$; also $\sum\lambda_i=\operatorname{trace}A$ and $\prod\lambda_i=\det A$ |
| Diagonalization | $AP=PD$ (no need to compute $P^{-1}$) |
| Linear map matrix | $A\mathbf e_1$, $A\mathbf e_2$ are the expected images |

## By computer (for Claude, or Ethan at home)
Exact fractions, no install needed (`python3`):
```python
from fractions import Fraction as F
def mul(A, B):
    return [[sum(A[i][k]*B[k][j] for k in range(len(B))) for j in range(len(B[0]))] for i in range(len(A))]
def inv(A):  # returns None if singular
    n = len(A); M = [[F(x) for x in r] + [F(int(i == j)) for j in range(n)] for i, r in enumerate(A)]
    for c in range(n):
        p = next((r for r in range(c, n) if M[r][c] != 0), None)
        if p is None: return None
        M[c], M[p] = M[p], M[c]; pv = M[c][c]; M[c] = [x / pv for x in M[c]]
        for r in range(n):
            if r != c: f = M[r][c]; M[r] = [a - f*b for a, b in zip(M[r], M[c])]
    return [r[n:] for r in M]
```
If `numpy`/`sympy` are installed: `sympy.Matrix(A).rref()`, `.inv()`, `.det()`, `.eigenvects()` give exact results.

> [!note] Use the computer to **check**, not to replace, the hand computation — the tutorials and exam are by hand.
