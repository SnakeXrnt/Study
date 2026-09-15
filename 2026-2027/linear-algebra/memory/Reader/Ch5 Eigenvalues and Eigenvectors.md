---
title: "Reader Ch 5 — Eigenvalues and Eigenvectors (pre-read)"
chapter: 5
lecture_date: 2026-10-13
reader: "printed p.79–102 (PDF p.83–106)"
tags: [linear-algebra, reader, eigenvalues, diagonalization]
status: pre-read
updated: 2026-09-15
---

# Ch 5 — Eigenvalues and Eigenvectors (pre-read)

Back to [[00 Index]] · Prev: [[Ch4 Determinants]] · Related: [[Ch6 Linear Transformations]]
Lecture 2026-10-13 covers §5.1–5.2 (+ practice test). §5.3 is used in tutorial exercise 5.20 a b c.

> [!abstract] Big picture
> Most vectors get turned **and** stretched by $A$. Eigenvectors only get **stretched** (by the eigenvalue $\lambda$). If there are enough of them to form a basis, then in that basis $A$ is just a diagonal matrix — a complicated coupled system splits into independent 1-D problems (used for vibrating masses and circuits).

## 5.1 Definition and computation (Def 5.1, 5.3, Lemma 5.4–5.5, Thm 5.6, Def 5.7)
- $\lambda$ is an **eigenvalue** of square $A$ if $A\mathbf x=\lambda\mathbf x$ for some $\mathbf x\neq\mathbf 0$; $\mathbf x$ is an **eigenvector**. ($\mathbf x=\mathbf 0$ never counts.)
- **Eigenspace** $E_\lambda=\operatorname{Null}(A-\lambda I)$ — a subspace; every nonzero vector in it is an eigenvector.
- $\lambda$ eigenvalue $\iff A-\lambda I$ not invertible $\iff\det(A-\lambda I)=0$.
- **Characteristic polynomial** $p(\lambda)=\det(A-\lambda I)$, degree $n$ → at most $n$ eigenvalues.

**Recipe:**
1. Compute $\det(A-\lambda I)$, factor, roots = eigenvalues.
2. For each $\lambda$: row reduce $A-\lambda I$, read $\operatorname{Null}$ → basis of $E_\lambda$.
3. ✅ Check $A\mathbf v=\lambda\mathbf v$.

**Ex 5.8:** $A=\begin{pmatrix}1&-1&0\\-1&2&-1\\0&-1&1\end{pmatrix}$, $p(\lambda)=(1-\lambda)(\lambda-3)\lambda$.
$E_1=\operatorname{Span}\{(1,0,-1)\}$, $E_3=\operatorname{Span}\{(1,-2,1)\}$, $E_0=\operatorname{Span}\{(1,1,1)\}$ (all checked).

> [!tip] Ways to save time — Exercise 5.15
> Triangular $A$: eigenvalues = diagonal entries. $\det A=\lambda_1\cdots\lambda_n$. $A^k\mathbf x=\lambda^k\mathbf x$. $A$ invertible ⇒ $1/\lambda$ is an eigenvalue of $A^{-1}$. $A$ and $A^T$ have the same eigenvalues.

## 5.2 Diagonalization (Thm 5.9, Cor 5.10, Thm 5.12, Def 5.13, Thm 5.14, Lemma 5.15–5.16)
- Eigenvectors for **distinct** eigenvalues are independent (Thm 5.9).
- $A$ **diagonalizable**: $P^{-1}AP=D$ for some invertible $P$ and diagonal $D$.
- **Theorem 5.14:** diagonalizable $\iff$ $\mathbb R^n$ has a basis of eigenvectors of $A$. Then $P=(\mathbf v_1\ \cdots\ \mathbf v_n)$ and $D=\operatorname{diag}(\lambda_1,\dots,\lambda_n)$ **in the same order**.
- Sufficient: $n$ distinct eigenvalues (Lemma 5.15), or $A$ symmetric (Lemma 5.16).
- Repeated eigenvalue: diagonalizable only if $\dim E_\lambda$ = multiplicity. Ex 5.17 ($\lambda=2$ double, $\dim E_2=2$) **is**; $\begin{pmatrix}1&1\\0&1\end{pmatrix}$ is **not** (Exercise 5.17a).
- Invertible and diagonalizable are **unrelated** (Exercise 5.17 a, b).
- Powers: $A^k=PD^kP^{-1}$ (Exercise 5.16).
- Check $AP=PD$ instead of computing $P^{-1}$.

### Complex eigenvalues (Ex 5.18, Def 5.19–5.20, Lemma 5.21, Ex 5.22)
- Rotation $\begin{pmatrix}0&1\\-1&0\end{pmatrix}$: $p=\lambda^2+1$ → no real eigenvalues; $\lambda=\pm i$ with eigenvectors $(1,\pm i)$.
- Real matrix: complex eigenvalues come in **conjugate pairs**, with conjugate eigenvectors → compute one, conjugate for the other.

## 5.3 Differential equations (examples only)
$\dot{\mathbf x}=A\mathbf x$ (or $\ddot{\mathbf x}=A\mathbf x$): set $\mathbf p=P^{-1}\mathbf x$ → $\dot{\mathbf p}=D\mathbf p$ = decoupled 1-D equations $\dot p_i=\lambda_ip_i\Rightarrow p_i=e^{\lambda_it}p_i(0)$; then $\mathbf x=P\mathbf p=\sum p_i(t)\mathbf v_i$.
- Mass–spring (§5.3.1): eigenvalues $0,-\frac km,-\frac{2k}M-\frac km$ → translation + two oscillation modes.
- RLC circuit (§5.3.2): eigenvalues $-1,\pm i$; Euler $\cos t=\frac{e^{it}+e^{-it}}2$, $\sin t=\frac{e^{it}-e^{-it}}{2i}$ turn it back into a real solution. Links to Calculus (2nd-order linear ODEs).

## Exercises
- Preparation (before 2026-10-13): **5.1–5.6**
- Tutorial (2026-10-20): **5.7–5.12, 5.15–5.18, 5.20 a b c**. Answers printed p.136–142 (PDF p.140–146).
