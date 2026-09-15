---
title: "Reader Ch 4 — Determinants (pre-read)"
chapter: 4
lecture_date: 2026-10-06
reader: "printed p.67–78 (PDF p.71–82)"
tags: [linear-algebra, reader, determinants]
status: pre-read
updated: 2026-09-15
---

# Ch 4 — Determinants (pre-read)

Back to [[00 Index]] · Prev: [[Ch3 Subspaces and Bases]] · Next: [[Ch5 Eigenvalues and Eigenvectors]]
Lectured together with [[Ch6 Linear Transformations]] §6.1–6.3 on 2026-10-06.

> [!abstract] Big picture
> One number per square matrix. $\det A\neq0$ ⇔ $A$ invertible, and $\lvert\det A\rvert$ is the **area/volume scale factor**. It is the tool that finds eigenvalues in Chapter 5.

## 4.1 Definition (Def 4.1, 4.3, Thm 4.5)
- $A_{ij}$ = the $(n-1)\times(n-1)$ matrix left after deleting row $i$ and column $j$. **Minor** $M_{ij}=\det A_{ij}$.
- $n=1$: $\det A=a_{11}$. $n=2$: $\det A=a_{11}a_{22}-a_{12}a_{21}$.
- $n>2$ (expansion along row 1): $\det A=a_{11}M_{11}-a_{12}M_{12}+\dots+(-1)^{n+1}a_{1n}M_{1n}$.
- **Theorem 4.5:** expand along **any** row $i$ or column $j$: $\det A=\sum_k(-1)^{i+k}a_{ik}M_{ik}$. Sign pattern $\begin{pmatrix}+&-&+\\-&+&-\\+&-&+\end{pmatrix}$. Pick the row/column with the most zeros.
- Notation $\lvert A\rvert$. Ex 4.4: a $4\times4$ example gives $\det A=-8$.

## 4.2 Properties (Lemma 4.7–4.8, Cor 4.9, Thm 4.10–4.18)
| Operation / fact | Effect on $\det$ |
|---|---|
| $\det A^T$ | $=\det A$ (so column rules = row rules) |
| add a multiple of one row to another | **no change** |
| multiply one row by $\alpha$ | $\times\alpha$ |
| swap two rows | $\times(-1)$ |
| two equal rows/columns, or a zero row/column | $\det=0$ |
| triangular matrix | product of the diagonal |
| $\det(AB)$ | $=\det A\cdot\det B$ |
| $\det(A^{-1})$ | $=1/\det A$ (Exercise 4.5c) |
| $\det(\alpha A)$, $A$ is $n\times n$ | $=\alpha^n\det A$ (every row scaled) |

**Efficient method (Ex 4.11):** row reduce to triangular form while **tracking factors** (each swap $-1$, each row division by $c$ means multiply the final det by $c$), then multiply the diagonal. Ex 4.11 result: $(-1)(-2)(-15)\cdot6=-180$.

> [!important] Theorem 4.13 → [[Invertibility Theorem]]
> $A$ invertible $\iff\det A\neq0$. Consequently $AB$ invertible $\iff$ both $A$ and $B$ invertible.

## Geometry (Thm 4.15, 4.18)
- Parallelogram with corners $\mathbf 0,\mathbf u,\mathbf v,\mathbf u+\mathbf v$: area $=\lvert\det(\mathbf u\ \mathbf v)\rvert$. Ex 4.16: $\mathbf u=(1,2),\mathbf v=(3,0)$ → $\lvert-6\rvert=6$.
- Parallelepiped from $\mathbf u,\mathbf v,\mathbf w$: volume $=\lvert\det(\mathbf u\ \mathbf v\ \mathbf w)\rvert$. Ex 4.19: volume 6.
- If no corner is at the origin: translate first (subtract one corner). Triangle = half the parallelogram (Exercise 4.6).

> [!warning] Traps
> - Forgetting the $(-1)^{i+j}$ sign in cofactor expansion.
> - Scaling a row during reduction and forgetting to compensate.
> - $\det(A+B)\neq\det A+\det B$.

## Exercises
- Preparation (before 2026-10-06): **4.1–4.3** (+ 6.1–6.3)
- Tutorial (2026-10-06 afternoon): **4.4–4.6** (+ 6.4–6.6, 6.9). Answers printed p.132–136 (PDF p.136–140).
