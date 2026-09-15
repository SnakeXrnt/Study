---
title: "Lecture 2 — Row Reduction, Matrix Algebra, Inverse and Transpose"
lecture: 2
chapter: 2
date: 2026-09-08
slides: ../../lectures_slides/Linear-Algebra-Lecture2.pdf
reader: "Ch 2, printed p.23–40 (PDF p.27–44)"
tags: [linear-algebra, lecture, matrices, inverse, transpose]
status: lectured
updated: 2026-09-15
---

# Lecture 2 — Row Reduction, Matrix Algebra, Inverse and Transpose

Back to [[00 Index]] · Prev: [[L01 Linear Systems]] · Next: [[Ch3 Subspaces and Bases]]
Rule sheets: [[Matrix Rules]] · [[Invertibility Theorem]] · Practice: [[Exercise Log#Chapter 2]]

> [!abstract] Big picture
> Lecture 1 used matrices only as bookkeeping. Now matrices become **objects you can add and multiply**. The key payoff: a system is just $A\mathbf x=\mathbf b$, and if $A$ has an **inverse**, the unique solution is $\mathbf x=A^{-1}\mathbf b$ — like dividing, but for matrices.

## 1. Row reduction warm-up (slide p.1)
$$\begin{cases}x_1+2x_2=-1\\2x_1+x_2+x_3=1\\-x_1+x_2=-1\end{cases}\qquad \left(\begin{array}{ccc|c}1&2&0&-1\\2&1&1&1\\-1&1&0&-1\end{array}\right)$$
$R_2-2R_1,\ R_3+R_1$ → $\left(\begin{array}{ccc|c}1&2&0&-1\\0&-3&1&3\\0&3&0&-2\end{array}\right)$; $R_3+R_2$ → $\left(\begin{array}{ccc|c}1&2&0&-1\\0&-3&1&3\\0&0&1&1\end{array}\right)$
**3 pivots for 3 unknowns → no free variables → exactly 1 solution.** Continue to RREF ($R_2\times(-\tfrac13)$, $R_1-2R_2$, then clear column 3):
$$\left(\begin{array}{ccc|c}1&0&0&\frac13\\0&1&0&-\frac23\\0&0&1&1\end{array}\right)\Rightarrow x_1=\tfrac13,\ x_2=-\tfrac23,\ x_3=1$$
✅ Check eq. 2: $\tfrac23-\tfrac23+1=1$.

## 2. Vectors in $\mathbb R^n$ (slide p.1 · reader §2.1)
- Column vector $\mathbf u=\begin{pmatrix}u_1\\ \vdots\\ u_n\end{pmatrix}\in\mathbb R^n$.
- **Addition** componentwise: $\begin{pmatrix}1\\-3\end{pmatrix}+\begin{pmatrix}1\\-1\end{pmatrix}=\begin{pmatrix}2\\-4\end{pmatrix}$ (geometrically: parallelogram rule).
- **Scalar multiplication**: $4\begin{pmatrix}1\\-3\end{pmatrix}=\begin{pmatrix}4\\-12\end{pmatrix}$ (stretch the arrow).
- A **vector space** (reader Def 2.1) is any set with $+$ and scalar $\cdot$ obeying 10 axioms (closed under both, commutative, associative, zero vector, negatives, $c(d\mathbf u)=(cd)\mathbf u$, $1\mathbf u=\mathbf u$, two distributive laws). $\mathbb R^n$ and $\mathbb R^{m\times n}$ are vector spaces (Exercise 2.20).

## 3. Matrix addition & special matrices (slide p.2 · reader §2.2)
- Same size only, entry by entry: $\begin{pmatrix}-2&3&1\\5&0&-4\end{pmatrix}+\begin{pmatrix}1&1&1\\1&1&1\end{pmatrix}=\begin{pmatrix}-1&4&2\\6&1&-3\end{pmatrix}$
- **Square** ($n\times n$), **zero** $0$, **diagonal** (only $a_{ii}$ nonzero), **identity** $I_n$ (diagonal of 1s), **upper triangular** ($a_{ij}=0$ for $i>j$, zeros below diagonal), **lower triangular** (zeros above).

## 4. Matrix × vector (slide p.2 · reader Def 2.4, Lemma 2.5)
For $A\in\mathbb R^{m\times n}$ and $\mathbf x\in\mathbb R^n$:
$$A\mathbf x=\begin{pmatrix}a_{11}x_1+\dots+a_{1n}x_n\\ \vdots\\ a_{m1}x_1+\dots+a_{mn}x_n\end{pmatrix}\in\mathbb R^m$$
> [!important] Size rule
> **number of columns of $A$ = number of components of $\mathbf x$.** Each entry of the result = (row $i$ of $A$) · $\mathbf x$ (dot product).

- Other view (reader Ex 3.9): $A\mathbf x=x_1\mathbf a_1+\dots+x_n\mathbf a_n$ — a **combination of the columns** of $A$. This is the idea behind Chapter 3.
- Linear: $A(\mathbf u+\mathbf v)=A\mathbf u+A\mathbf v$, $A(\alpha\mathbf u)=\alpha A\mathbf u$.

## 5. Matrix × matrix (slide p.2–3 · reader Def 2.6, Lemma 2.8)
For $A$ ($k\times m$) and $B=(\mathbf b_1\ \cdots\ \mathbf b_n)$ ($m\times n$):
$$AB=\begin{pmatrix}A\mathbf b_1 & A\mathbf b_2 & \cdots & A\mathbf b_n\end{pmatrix}\quad(k\times n),\qquad (AB)_{ij}=a_{i1}b_{1j}+\dots+a_{im}b_{mj}$$
"entry $(i,j)$ = row $i$ of $A$ · column $j$ of $B$". Inner sizes must match: $(k\times\mathbf m)(\mathbf m\times n)=k\times n$.

Slide example ($2\times3$ times $3\times2$ = $2\times2$):
$$\begin{pmatrix}2&5&-1\\7&-4&3\end{pmatrix}\begin{pmatrix}4&-1\\2&3\\0&1\end{pmatrix}=\begin{pmatrix}18&12\\20&-16\end{pmatrix}$$
(e.g. $(1,1)$: $2\cdot4+5\cdot2+(-1)\cdot0=18$.)

**Rules that work:** $A(BC)=(AB)C$, $A(B+C)=AB+AC$, $(A+B)C=AC+BC$, $A(\alpha B)=\alpha(AB)$, $I_mA=A=AI_n$, $A^0=I$, $A^rA^s=A^{r+s}$, $(A^r)^s=A^{rs}$ (square $A$).

> [!warning] Rules that FAIL for matrices (slide p.2–3 · reader §2.2)
> - $AB\neq BA$ in general (one may not even be defined, or have a different size).
> - $AB=0$ does **not** imply $A=0$ or $B=0$: $\begin{pmatrix}1&0\\0&0\end{pmatrix}\begin{pmatrix}0&0\\0&1\end{pmatrix}=0$.
> - $AC=AD$ with $A\neq0$ does **not** imply $C=D$ (no cancelling unless $A$ is invertible — Exercise 2.19a).

## 6. Row operations are matrix multiplications (slide p.3, p.7 · reader Ex 2.10)
Doing a row operation on $A_1$ = multiplying on the left by an **elementary matrix** $T$ = $I$ with the same row operation applied.
Slide: $R_2-2R_1$ on $\begin{pmatrix}1&2&0&-1\\2&1&1&1\\-1&1&0&-1\end{pmatrix}$ is $A_2=TA_1$ with $T=\begin{pmatrix}1&0&0\\-2&1&0\\0&0&1\end{pmatrix}$.
Every elementary matrix is invertible (undo the operation) — Exercise 2.9e.

## 7. The inverse (slide p.4 · reader §2.3)
- $A$ ($n\times n$) is **regular / invertible** if there is $C$ with $AC=CA=I$. Otherwise **singular**.
- The inverse is **unique** (Theorem 2.12) → write $A^{-1}$.
- **One side is enough** (Lemma 2.13): if $AB=I$ for square $A,B$, then $B=A^{-1}$.

> [!important] Important Fact 2 of Lecture 2 (reader Theorem 2.14)
> $A$ regular ⇒ $A\mathbf x=\mathbf b$ has the **unique** solution $\mathbf x=A^{-1}\mathbf b$ for **every** $\mathbf b\in\mathbb R^n$.
> $A$ singular ⇒ for some $\mathbf b$ no solution; whenever a solution exists there are infinitely many.

### 2×2 shortcut (slide p.4 — only for 2×2!)
$$B=\begin{pmatrix}a&b\\c&d\end{pmatrix},\ ad-bc\neq0\ \Rightarrow\ B^{-1}=\frac1{ad-bc}\begin{pmatrix}d&-b\\-c&a\end{pmatrix}$$
"swap the diagonal, negate the off-diagonal, divide by $ad-bc$." ($ad-bc$ is the determinant → [[Ch4 Determinants]].)

**Slide example:** $-7x_1+3x_2=2,\ 5x_1-2x_2=1$. $A=\begin{pmatrix}-7&3\\5&-2\end{pmatrix}$, $ad-bc=14-15=-1$.
$A^{-1}=\frac1{-1}\begin{pmatrix}-2&-3\\-5&-7\end{pmatrix}=\begin{pmatrix}2&3\\5&7\end{pmatrix}$, so $\mathbf x=A^{-1}\mathbf b=\begin{pmatrix}2\cdot2+3\cdot1\\5\cdot2+7\cdot1\end{pmatrix}=\begin{pmatrix}7\\17\end{pmatrix}$.
✅ $-49+51=2$, $35-34=1$.

## 8. Algorithm to find $A^{-1}$ (slide p.5–6 · reader Theorem 2.15)
1. Write $(A\mid I)$.
2. Row reduce to RREF $(B\mid C)$.
3. If $B=I$ then $A^{-1}=C$. Otherwise $A$ is **singular**. (You may stop as soon as a zero row appears on the left.)

*Why it works (slide p.7):* the row operations are $T_1,\dots,T_k$ with $T_k\cdots T_1A=I$, so $T_k\cdots T_1=A^{-1}$ — and applying the same operations to $I$ builds exactly that product.
*Other view (reader):* solving $A\mathbf x_i=\mathbf e_i$ for all $n$ columns at once.

**Slide example 1 (singular):** $A=\begin{pmatrix}2&1&-4\\-4&-1&6\\-2&2&-2\end{pmatrix}$. $R_2+2R_1,\ R_3+R_1$, then $R_3-3R_2$:
$$\left(\begin{array}{ccc|ccc}2&1&-4&1&0&0\\0&1&-2&2&1&0\\0&0&0&-5&-3&1\end{array}\right)$$
zero row on the left → can never become $I_3$ → **singular**.
> [!note] Lecturer's note on the slide
> In class the matrix was accidentally written with $+1$ (not $-1$) in row 2, column 2; that version is regular but messier. The slide PDF uses $-1$.

**Slide example 2:** $A=\begin{pmatrix}1&2\\3&4\end{pmatrix}$: $R_2-3R_1$, $R_2\times(-\tfrac12)$, $R_1-2R_2$ →
$$A^{-1}=\begin{pmatrix}-2&1\\ \frac32&-\frac12\end{pmatrix}$$
(✅ 2×2 formula: $\frac1{-2}\begin{pmatrix}4&-2\\-3&1\end{pmatrix}$ — same.)

**Reader Example 2.16:** $\begin{pmatrix}1&0&-1\\4&2&3\\5&3&7\end{pmatrix}^{-1}=\begin{pmatrix}\frac53&-1&\frac23\\-\frac{13}3&4&-\frac73\\ \frac23&-1&\frac23\end{pmatrix}$ (verified). Reader Example 2.17 $\begin{pmatrix}1&-2&1\\0&1&-1\\2&-1&-1\end{pmatrix}$ is singular.

## 9. Transpose (slide p.6 · reader §2.4)
$A^T$: rows become columns, $(A^T)_{ij}=A_{ji}$; $m\times n\to n\times m$.
$$A=\begin{pmatrix}-5&2\\1&-3\\0&4\end{pmatrix}\Rightarrow A^T=\begin{pmatrix}-5&1&0\\2&-3&4\end{pmatrix}$$
**Symmetric:** $A^T=A$ (must be square).

### Properties of inverse / transpose (slide p.6 · reader Lemma 2.20, Exercise 2.16)
| Property | Note |
|---|---|
| $(A^T)^T=A$ | |
| $(A+B)^T=A^T+B^T$ | |
| $(AB)^T=B^TA^T$ | order **flips** |
| $(AB)^{-1}=B^{-1}A^{-1}$ | order **flips** (socks and shoes) |
| $(A^T)^{-1}=(A^{-1})^T$ | $A$ regular |
| $(A^{-1})^{-1}=A$ | |
| $(A_1\cdots A_k)^{-1}=A_k^{-1}\cdots A_1^{-1}$ | Exercise 2.16d |

Upper/lower triangular square matrices are invertible exactly when all diagonal entries are nonzero (Exercise 2.5).

## Exercises for this chapter
- Preparation (before 2026-09-08): **2.1–2.5** (self-study, no answer key)
- Tutorial (2026-09-15): **2.6–2.18** (answers in [[Exercise Log#Answer key — Chapter 2 tutorial]]); 2.19–2.20 extra

## 📝 Live lecture notes — 2026-09-08
*(Lecture was before this vault existed. Add anything Ethan remembers or asks about here.)*
