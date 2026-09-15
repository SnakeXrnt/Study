---
title: Invertibility Theorem
tags: [linear-algebra, reference, invertibility]
updated: 2026-09-15
---

# 🔑 Invertibility Theorem (square matrices)

Back to [[00 Index]] · See also [[Matrix Rules]]

The course never states this as one theorem, but these facts are spread over the reader. For an $n\times n$ matrix $A$ (and $T(\mathbf x)=A\mathbf x$), **all of these are equivalent** — if one is true, all are true; if one fails, all fail.

| # | Statement | Source | Chapter |
|---|---|---|---|
| 1 | $A$ is invertible (regular) | Def 2.11 | 2 |
| 2 | RREF of $A$ is $I_n$ | Thm 2.15 | 2 |
| 3 | $A$ has $n$ pivots (a pivot in every row **and** every column) | Thm 2.15, Ex 2.17 | 2 |
| 4 | $A\mathbf x=\mathbf b$ has a **unique** solution for every $\mathbf b$ | Thm 2.14 | 2 |
| 5 | $A\mathbf x=\mathbf b$ is consistent for every $\mathbf b$ | Ex 2.15a | 2 |
| 6 | $A\mathbf x=\mathbf 0$ has only $\mathbf x=\mathbf 0$ | Ex 2.17b | 2 |
| 7 | $A$ is a product of elementary matrices | slide L2 p.7 | 2 |
| 8 | $A^T$ is invertible | Lemma/Ex 2.16b | 2 |
| 9 | $\operatorname{Null}A=\{\mathbf 0\}$ | Thm 3.24 | 3 |
| 10 | $\operatorname{Col}A=\mathbb R^n$ | Thm 3.24 | 3 |
| 11 | columns of $A$ are linearly independent | Thm 3.14 + 3.24 | 3 |
| 12 | columns of $A$ form a basis of $\mathbb R^n$ | Thm 3.17, Ex 3.16e | 3 |
| 13 | $\det A\neq0$ | Thm 4.13 | 4 |
| 14 | $0$ is **not** an eigenvalue of $A$ | Lemma 5.5 | 5 |
| 15 | $T$ is one-to-one | Thm 6.11, 6.15 | 6 |
| 16 | $T$ is onto | Thm 6.11, 6.15 | 6 |

**Singular** = all of them fail: RREF has a zero row, some $\mathbf b$ gives no solution, $A\mathbf x=\mathbf 0$ has infinitely many solutions, $\det A=0$, …

> [!warning] Only for square matrices
> For non-square $A$ (say $m\times n$), "columns independent" (pivot in every column) and "$\operatorname{Col}A=\mathbb R^m$" (pivot in every row) are **different** conditions (Ex 3.25, Exercise 3.14).
