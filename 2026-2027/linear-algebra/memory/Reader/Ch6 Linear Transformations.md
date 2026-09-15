---
title: "Reader Ch 6 — Linear Transformations (pre-read)"
chapter: 6
lecture_date: 2026-10-06
reader: "printed p.103–118 (PDF p.107–122)"
tags: [linear-algebra, reader, linear-transformations]
status: pre-read
updated: 2026-09-15
---

# Ch 6 — Linear Transformations (pre-read)

Back to [[00 Index]] · Lectured with [[Ch4 Determinants]] on 2026-10-06 (§6.1–6.3 in the schedule; §6.4 geometric examples are used in exercises 6.2 and 6.7)

> [!abstract] Big picture
> A matrix is a **machine** $\mathbb R^n\to\mathbb R^k$: vector in, vector out. The "linear" machines are exactly the matrix ones, and the matrix is found by feeding in $\mathbf e_1,\dots,\mathbf e_n$ and recording what comes out.

## 6.1–6.2 Linear transformations (Def 6.3, Thm 6.5, Def 6.7–6.9, Thm 6.8–6.11)
- $F:\mathbb R^n\to\mathbb R^k$ is **linear** if $F(\mathbf u+\mathbf v)=F(\mathbf u)+F(\mathbf v)$ and $F(\alpha\mathbf u)=\alpha F(\mathbf u)$.
- Quick non-linearity test: $F(\mathbf 0)\neq\mathbf 0$ ⇒ not linear (so $f(x)=ax+b$ is linear only if $b=0$ — Exercise 6.3). Also anything with $x^2$, $x_1x_2$, $+1$ …
- **Theorem 6.5:** every linear $F$ is $F(\mathbf u)=A\mathbf u$ for a unique $k\times n$ **standard / representation matrix** $[F]=A=\big(F(\mathbf e_1)\ \cdots\ F(\mathbf e_n)\big)$.
  - Ex 6.6: $F(u_1,u_2)=(u_1-u_2,\ u_1+u_2,\ 2u_2)$ → $[F]=\begin{pmatrix}1&-1\\1&1\\0&2\end{pmatrix}$.
- **Kernel** $\ker T=\{\mathbf x\mid T\mathbf x=\mathbf 0\}=\operatorname{Null}A$; **image/range** $\operatorname{im}T=\operatorname{Col}A$ (Thm 6.8).
- **One-to-one** ($T\mathbf u=T\mathbf v\Rightarrow\mathbf u=\mathbf v$) $\iff\ker T=\{\mathbf 0\}\iff$ columns of $A$ independent (pivot in every **column**).
- **Onto** ($\operatorname{im}T=\mathbb R^k$) $\iff\operatorname{Col}A=\mathbb R^k$ (pivot in every **row**).

## 6.3 Composition and inverse (Def 6.13, Lemma 6.14, Thm 6.15)
- $(G\circ F)(\mathbf u)=G(F(\mathbf u))$, "G after F". If $[F]=A$ and $[G]=B$ then $[G\circ F]=BA$ — **the matrix of the map applied first goes on the right**.
- $F:\mathbb R^n\to\mathbb R^n$ invertible $\iff$ $[F]$ invertible, and $[F^{-1}]=[F]^{-1}$.
- **Theorem 6.15 (square case):** invertible $\iff$ onto $\iff$ one-to-one → [[Invertibility Theorem]]. A map $\mathbb R^n\to\mathbb R^k$ with $k\neq n$ is never invertible.

## 6.4 Geometric examples in $\mathbb R^2$
| Map | Matrix |
|---|---|
| Rotation by $\varphi$ (counter-clockwise) | $\begin{pmatrix}\cos\varphi&-\sin\varphi\\ \sin\varphi&\cos\varphi\end{pmatrix}$ |
| Orthogonal projection onto line with **unit** direction $\mathbf n=(n_1,n_2)$ | $\begin{pmatrix}n_1^2&n_1n_2\\n_1n_2&n_2^2\end{pmatrix}$ |
| Reflection in that line ($M=2P-I$) | $\begin{pmatrix}2n_1^2-1&2n_1n_2\\2n_1n_2&2n_2^2-1\end{pmatrix}$ |
| Scaling by $\alpha$ | $\alpha I$ |

Projection is neither onto nor one-to-one; rotation, reflection, scaling ($\alpha\neq0$) are invertible.
> [!tip] Usually easier (Ex 6.20)
> Don't memorise — just find where $\mathbf e_1$ and $\mathbf e_2$ go (draw it) and use those as the columns. Remember to normalise $\mathbf n$ (divide by its length) before using the projection formula.

Exercise 6.8 idea: knowing $T$ on two independent vectors determines $T$ — solve for $T(\mathbf e_1),T(\mathbf e_2)$ by linearity.

## Exercises
- Preparation (before 2026-10-06): **6.1–6.3**
- Tutorial (2026-10-06 afternoon): **6.4–6.6, 6.9**. Answers printed p.143–148 (PDF p.147–152).
