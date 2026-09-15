---
title: Row Reduction Algorithm
tags: [linear-algebra, reference, row-reduction]
updated: 2026-09-15
---

# 🔧 Row Reduction Algorithm (Gauss-Jordan)

Back to [[00 Index]] · Theory: [[L01 Linear Systems]] · Checks: [[Verification Methods]]

## The three allowed moves (Def 1.12)
1. $R_i + cR_j$ — add a multiple of another row
2. $cR_i$ with $c\neq0$ — scale a row
3. $R_i\leftrightarrow R_j$ — swap rows

Write the move next to the row it changes, like the lecturer: `R2 − 2R1`.

## Forward phase → echelon form (reader steps i–iii)
1. Find the **leftmost column that isn't all zeros**.
2. Get a nonzero entry to the top (swap if needed). **Prefer a 1** (or make one) to avoid fractions. This is the **pivot**.
3. Use the pivot row to make **every entry below the pivot 0**.
4. Ignore that row (mentally cover it) and repeat on the rows below.

## Backward phase → reduced echelon form (steps iv–v)
5. Scale each pivot row so the pivot is **1**.
6. Starting from the **bottom** pivot, make every entry **above** each pivot 0.

## Read the result
Let the augmented matrix be $(A\mid\mathbf b)$ in echelon form.
| What you see | Meaning |
|---|---|
| a row $(0\ \cdots\ 0\mid c)$ with $c\neq0$ (pivot in last column) | **inconsistent, no solutions** (Thm 1.22) |
| a row $(0\ \cdots\ 0\mid 0)$ | harmless, delete it |
| pivot in every variable column | **unique** solution |
| some variable column without pivot | that variable is **free** → **infinitely many** |

Then write basic variables in terms of free ones; mark free ones explicitly ("$x_3$ is free"). Parametric vector form (Ch 3): $\mathbf x=\mathbf p+t_1\mathbf v_1+\dots$

## Special uses
| Task | Row reduce | Read off |
|---|---|---|
| Solve $A\mathbf x=\mathbf b$ | $(A\mid\mathbf b)$ | Thm 1.22 + free variables |
| Inverse | $(A\mid I)$ | left becomes $I$ ⇒ right is $A^{-1}$; zero row on left ⇒ singular (Thm 2.15) |
| Several right-hand sides | $(A\mid\mathbf b_1\ \mathbf b_2)$ | each column separately |
| $\operatorname{Null}A$ | $A$ only | free-variable vectors |
| Independence of $\mathbf v_1..\mathbf v_p$ | $(\mathbf v_1\cdots\mathbf v_p)$ | pivot in every column ⇔ independent |
| Basis of $\operatorname{Col}A$ | $A$ | **original** columns at pivot positions |
| Determinant | $A$ to triangular | product of diagonal × correction factors |
| Eigenspace | $A-\lambda I$ | its null space |

## Parameters $\alpha,\beta$ in the matrix (Ex 1.25)
1. Move a row **without** parameters (ideally starting with 1) to the top.
2. Eliminate as usual; never divide by an expression that might be 0.
3. When an expression like $\alpha-2$ lands in a pivot spot, **split cases**: $\alpha\neq2$ (it's a pivot) vs $\alpha=2$ (substitute and continue).
4. Summarise: for which values none / one / infinitely many.

## Tips
- Do one column at a time; recheck each new row before continuing (one sign slip ruins everything after it).
- Fractions: scale a row by the denominator first (the lecturer did $R_2\times10$ on the acid example).
- Echelon form is enough to decide *how many* solutions; RREF is needed to *write* them cleanly.
