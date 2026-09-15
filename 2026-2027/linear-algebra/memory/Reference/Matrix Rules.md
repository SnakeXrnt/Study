---
title: Matrix Rules
tags: [linear-algebra, reference, matrices]
updated: 2026-09-15
---

# 📐 Matrix Rules

Back to [[00 Index]] · Theory: [[L02 Matrix Algebra and Inverses]] · See also [[Invertibility Theorem]]

## Sizes
- $m\times n$ = **rows × columns**. $a_{ij}$ = row $i$, column $j$.
- $A\mathbf x$: $A$ is $m\times n$, $\mathbf x\in\mathbb R^n$, result in $\mathbb R^m$.
- $AB$: $(k\times\underline m)(\underline m\times n)=k\times n$ — inner numbers must match.
- $A^T$: $m\times n\to n\times m$. $AA^T$ ($m\times m$) and $A^TA$ ($n\times n$) always exist; $AA$ only if square.

## Multiplication
- $(AB)_{ij}$ = row $i$ of $A$ · column $j$ of $B$.
- $AB=(A\mathbf b_1\ \cdots\ A\mathbf b_n)$; $A\mathbf x=x_1\mathbf a_1+\dots+x_n\mathbf a_n$.
- Last column of $B$ all zero ⇒ last column of $AB$ all zero (Exercise 2.8b).

## ✅ Works
| Rule | |
|---|---|
| $A(BC)=(AB)C$ | associative |
| $A(B+C)=AB+AC$, $(A+B)C=AC+BC$ | distributive (keep left/right sides!) |
| $A(\alpha B)=\alpha(AB)$ | scalars move freely |
| $IA=A=AI$ | identity |
| $A^0=I,\ A^rA^s=A^{r+s},\ (A^r)^s=A^{rs}$ | square only |

## ❌ Does NOT work
| False claim | Counterexample / fix |
|---|---|
| $AB=BA$ | usually false; sizes may even differ |
| $AB=0\Rightarrow A=0$ or $B=0$ | $\begin{pmatrix}1&0\\0&0\end{pmatrix}\begin{pmatrix}0&0\\0&1\end{pmatrix}=0$ |
| $AC=AD\Rightarrow C=D$ | only if $A$ invertible (multiply by $A^{-1}$ on the **left**) |
| $(A+B)^2=A^2+2AB+B^2$ | $=A^2+AB+BA+B^2$ |
| $(AB)^T=A^TB^T$ | $=B^TA^T$ |
| $(AB)^{-1}=A^{-1}B^{-1}$ | $=B^{-1}A^{-1}$ |
| "divide by a matrix" | multiply by $A^{-1}$ on the correct side |

## Transpose
$(A^T)^T=A$ · $(A+B)^T=A^T+B^T$ · $(AB)^T=B^TA^T$ · $(ABC)^T=C^TB^TA^T$ · $(A^k)^T=(A^T)^k$ · symmetric: $A^T=A$

## Inverse (square only)
- Definition $AB=BA=I$; one side suffices (Lemma 2.13); unique (Thm 2.12).
- 2×2: $\begin{pmatrix}a&b\\c&d\end{pmatrix}^{-1}=\dfrac1{ad-bc}\begin{pmatrix}d&-b\\-c&a\end{pmatrix}$, exists iff $ad-bc\neq0$.
- General: row reduce $(A\mid I)\to(I\mid A^{-1})$.
- $(A^{-1})^{-1}=A$ · $(AB)^{-1}=B^{-1}A^{-1}$ · $(A^T)^{-1}=(A^{-1})^T$ · $(A_1\cdots A_k)^{-1}=A_k^{-1}\cdots A_1^{-1}$
- $A=PBP^{-1}\iff B=P^{-1}AP$ (Exercise 2.19b).
- Triangular is invertible ⇔ no zero on the diagonal.

## Elementary matrices
$T$ = $I$ with one row operation applied; $TA$ = that operation on $A$. Inverse = the undo operation.
| Operation on $4\times\cdot$ matrix | $T$ |
|---|---|
| $R_3+2R_1$ | $I$ with $t_{31}=2$ |
| $3R_2$ | $I$ with $t_{22}=3$ |
| $R_2\leftrightarrow R_4$ | $I$ with rows 2 and 4 swapped |

## Determinants (from [[Ch4 Determinants]])
$\det(AB)=\det A\det B$ · $\det A^T=\det A$ · $\det A^{-1}=1/\det A$ · $\det(\alpha A)=\alpha^n\det A$ · swap $\times(-1)$ · scale row $\times\alpha$ · add multiple: no change · triangular: product of diagonal
