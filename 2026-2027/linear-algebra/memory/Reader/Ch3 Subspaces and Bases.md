---
title: "Reader Ch 3 — Subspaces and Bases (pre-read)"
chapter: 3
lecture_date: 2026-09-22
reader: "printed p.41–65 (PDF p.45–69)"
tags: [linear-algebra, reader, subspaces, span, basis]
status: pre-read
updated: 2026-09-15
---

# Ch 3 — Subspaces and Bases (pre-read)

Back to [[00 Index]] · Prev: [[L02 Matrix Algebra and Inverses]] · Next: [[Ch4 Determinants]]
Summary of the reader, written before the lecture. When Lecture 3 happens, create `Lectures/L03 ...` from this and add the slides.

> [!abstract] Big picture
> Chapter 1 answered "how many solutions?" by computation. Chapter 3 gives the **structure**: the solutions of $A\mathbf x=\mathbf 0$ form a flat "sub-world" (a line, plane, … through the origin) called a **subspace**, and the solutions of $A\mathbf x=\mathbf b$ are that sub-world **shifted** by one particular solution. A **basis** is the smallest set of arrows that builds the whole subspace.

## 3.1 Subspaces (Def 3.1)
$D\subseteq\mathbb R^n$ is a **(linear) subspace** if
1. $\mathbf 0\in D$
2. closed under addition: $\mathbf u,\mathbf v\in D\Rightarrow\mathbf u+\mathbf v\in D$
3. closed under scalar multiplication: $\mathbf v\in D,\ \alpha\in\mathbb R\Rightarrow\alpha\mathbf v\in D$

Smallest subspace $\{\mathbf 0\}$, largest $\mathbb R^n$. A line is a subspace **only if it passes through the origin** (Ex 3.2): $\ell=\{\alpha\mathbf q\}$.
> [!tip] Fast "not a subspace" test
> Does it contain $\mathbf 0$? If not → not a subspace. (E.g. the solution set of $A\mathbf x=\mathbf b$ with $\mathbf b\neq\mathbf 0$.)

## 3.2 Null space (Lemma 3.3, Def 3.4)
- $A\mathbf x=\mathbf 0$ is **homogeneous**; $\mathbf b\neq\mathbf 0$ **nonhomogeneous**.
- $\operatorname{Null}A=\{\mathbf x\in\mathbb R^n\mid A\mathbf x=\mathbf 0\}$ is a subspace of $\mathbb R^n$ ($n$ = number of **columns**).
- To compute: row reduce **only $A$** (the zero column never changes).

## 3.3 Linear combinations, span, column space (Def 3.5, 3.7, 3.11)
- **Linear combination:** $\mathbf w=\alpha_1\mathbf v_1+\dots+\alpha_p\mathbf v_p$.
- To test "is $\mathbf w$ a combination of $\mathbf v_1,\dots,\mathbf v_p$?": row reduce $(\mathbf v_1\ \cdots\ \mathbf v_p\mid\mathbf w)$ and apply Theorem 1.22 (Ex 3.6).
- **Span** $\{\mathbf v_1,\dots,\mathbf v_p\}=\langle\mathbf v_1,\dots,\mathbf v_p\rangle$ = all linear combinations = the smallest subspace containing them.
- **Parametric vector form:** solution set $=\mathbf p+\operatorname{Span}\{\mathbf v_1,\dots,\mathbf v_q\}$ (not unique as a description; Ex 3.8–3.9).
  - Ex 3.8: $\mathbf x=\begin{pmatrix}-58\\-101\\9\\0\end{pmatrix}+x_4\begin{pmatrix}-13\\-25\\2\\1\end{pmatrix}$
- **Theorem 3.10:** if $\mathbf p$ is one solution of $A\mathbf x=\mathbf b$, all solutions are $\mathbf p+\operatorname{Null}A$.
- **Column space** $\operatorname{Col}A=\{\mathbf b\mid A\mathbf x=\mathbf b\text{ is consistent}\}=\operatorname{Span}\{\text{columns of }A\}\subseteq\mathbb R^m$ ($m$ = number of **rows**).

## 3.4 Linear independence, basis, dimension (Def 3.13, Thm 3.14, Def 3.16, Thm 3.17)
- **Dependent:** one vector is a combination of the others (or the set is just $\{\mathbf 0\}$). **Independent:** not dependent.
- **Theorem 3.14 (the test):** independent $\iff$ $\alpha_1\mathbf v_1+\dots+\alpha_p\mathbf v_p=\mathbf 0$ only for all $\alpha_i=0$ $\iff$ $(\mathbf v_1\ \cdots\ \mathbf v_p)\boldsymbol\alpha=\mathbf 0$ has only the trivial solution $\iff$ **a pivot in every column**.
  - Ex 3.15: $\begin{pmatrix}1\\1\\1\end{pmatrix},\begin{pmatrix}2\\1\\2\end{pmatrix},\begin{pmatrix}1\\2\\3\end{pmatrix}$ → RREF $=I_3$ → independent.
- **Basis** of $V$: independent vectors that span $V$. **Dimension** = number of basis vectors (same for every basis — Exercise 3.19).
- **Theorem 3.17:** every subspace has a basis; $p\le n$, and $p=n\Rightarrow V=\mathbb R^n$; any spanning set has at least $p$ vectors.
- More than $n$ vectors in $\mathbb R^n$ are always dependent (Exercise 3.16d).

### Finding a basis for $\operatorname{Span}S=\operatorname{Col}A$
**Method 1 — pivot columns (Ex 3.19):** put the vectors as columns of $A$, find an echelon form; the columns **of the original $A$** in the pivot positions form a basis.
> [!warning] Ex 3.20 trap
> Row operations **change** the column space. Take the basis vectors from the **original** matrix, never from the echelon form.

**Method 2 — column operations (Ex 3.21):** column operations **keep** $\operatorname{Col}A$ (but change the solution set). Reduce to a simple form; the nonzero columns are a (nicer) basis.

| Goal | Allowed operations |
|---|---|
| Solve $A\mathbf x=\mathbf b$, find $\operatorname{Null}A$ | **row** operations only |
| Basis for $\operatorname{Col}A$ | row ops (then take original pivot columns) **or** column ops |

### Coordinates (Def 3.22)
If $\mathcal A=\{\mathbf v_1,\dots,\mathbf v_p\}$ is a basis of $V$ and $\mathbf x=\alpha_1\mathbf v_1+\dots+\alpha_p\mathbf v_p$, then $[\mathbf x]_{\mathcal A}=(\alpha_1,\dots,\alpha_p)^T$. **Order of the basis matters.** Coordinates are unique (Exercise 3.18). Ex 3.23: solve the augmented system; pivot in last column ⇒ $\mathbf x\notin V$.

## Theorem 3.24 → [[Invertibility Theorem]]
Square $A$: invertible $\iff\operatorname{Null}A=\{\mathbf 0\}\iff\operatorname{Col}A=\mathbb R^n$. (Only for **square** matrices — Ex 3.25 shows a $2\times3$ with $\operatorname{Col}=\mathbb R^2$ but nontrivial null space.)

## Exercises
- Preparation (before 2026-09-22): **3.1–3.5**
- Tutorial (2026-09-29): **3.6–3.15, 3.16 a b e** (answers reader printed p.125–132 = PDF p.129–136; **render pages, don't trust extracted matrices**)
