---
title: Common Mistakes
tags: [linear-algebra, practice, mistakes]
updated: 2026-09-15
---

# ⚠️ Common Mistakes

Back to [[00 Index]] · See [[Student Profile]], [[Verification Methods]]

No linear algebra sessions with Ethan yet, so the tables below are **predicted traps** (from the reader, the slides, and Ethan's Calculus A error patterns). When Ethan actually makes a mistake, move it to **Ethan's real mistakes** with the date and exercise.

## Ethan's real mistakes
| Date | Exercise | Mistake | Fix |
|---|---|---|---|
| | | | |

## Carried over from Calculus A (known weak spots)
| Pattern | How it shows up here |
|---|---|
| Fraction simplification | Row reduction with $\frac13$, $-\frac23$ … → scale rows to clear denominators first |
| Minus signs | $R_3+R_1$ vs $R_3-R_1$; negating off-diagonals in the 2×2 inverse; cofactor signs |
| Skipping the "rule first" step | Name the theorem (1.22, 2.13, 2.15) before computing |
| Not verifying | Plug the solution back in, multiply $AA^{-1}$ |

## Predicted — Chapter 1 (row reduction)
| Trap | Fix |
|---|---|
| Changing the left part of a row but not the augmented column | Apply every operation to the **whole** row |
| Arithmetic slip early → everything after is wrong | Recheck each new row; at the end plug the answer into the **original** system |
| Calling $(0\ 0\ 0\mid 0)$ a contradiction | Only $(0\cdots0\mid c\neq0)$ is; a zero row is harmless |
| Dividing a row by $\alpha$ | $\alpha$ might be 0 — swap rows and split cases |
| Forgetting to say which variables are free | Write "$x_3$ is free" explicitly |
| Reading basic/free variables from a non-echelon matrix | Get echelon form first |
| Thinking "more unknowns than equations" means inconsistent | It means **not unique** (if consistent) |

## Predicted — Chapter 2 (matrix algebra)
| Trap | Fix |
|---|---|
| $m\times n$ read as columns × rows | **R**ows first ("RC", like "Roman Catholic") |
| Multiplying without checking sizes | Inner numbers must match; write sizes above each matrix |
| $AB=BA$ assumed | Order matters; keep left/right |
| Cancelling: $AC=AD\Rightarrow C=D$ | Only if $A$ invertible, multiply by $A^{-1}$ on the left |
| $(AB)^{-1}=A^{-1}B^{-1}$, $(AB)^T=A^TB^T$ | Order **flips** |
| Using the 2×2 inverse formula on 3×3 | 3×3 and up: $(A\mid I)$ |
| 2×2 formula: forgetting to swap $a,d$ or negate $b,c$ | "swap diagonal, negate off-diagonal, divide by $ad-bc$" |
| Elementary matrix: applying the op to $A$ instead of to $I$ | $T$ = operation applied to $I$ |
| $(A\mid I)$: stopping with left side not exactly $I$ | Must be RREF; zero row on the left = singular |

## Predicted — later chapters (watch when they come)
| Chapter | Trap | Fix |
|---|---|---|
| 3 | Basis of $\operatorname{Col}A$ taken from echelon-form columns | Take the **original** columns at the pivot positions |
| 3 | "Contains $\mathbf 0$" forgotten in subspace checks | Check $\mathbf 0$ first |
| 3 | $\operatorname{Null}A\subseteq\mathbb R^n$ vs $\operatorname{Col}A\subseteq\mathbb R^m$ mixed up | Null lives with the **input** ($n$ columns), Col with the **output** ($m$ rows) |
| 4 | Cofactor sign $(-1)^{i+j}$ forgotten | Draw the $+-+$ pattern |
| 4 | Row swap / row scaling during reduction not compensated | Keep a running factor |
| 5 | Zero vector given as an eigenvector | Eigenvectors are **nonzero** |
| 5 | Columns of $P$ in a different order from $\lambda$'s in $D$ | Same order |
| 5 | Repeated eigenvalue assumed diagonalizable (or not) | Compare $\dim E_\lambda$ with the multiplicity |
| 6 | Matrix of $G\circ F$ written $AB$ | $[G\circ F]=[G][F]=BA$ (first map on the right) |
| 6 | Projection formula with a non-unit $\mathbf n$ | Normalise $\mathbf n$ first |
