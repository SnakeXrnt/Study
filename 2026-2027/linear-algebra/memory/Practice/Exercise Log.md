---
title: Exercise Log
tags: [linear-algebra, practice]
updated: 2026-09-15
---

# ✍️ Exercise Log

Back to [[00 Index]] · Errors: [[Common Mistakes]] · Schedule: [[Course Info]]

Two parts per chapter: the **answer key** (from reader Ch 7, read from rendered page images, numeric ones re-checked with exact arithmetic on 2026-09-15) and **Ethan's worked exercises** (fill in during sessions: ✅ right first time · 🟡 with hints · ❌ wrong → link to the mistake).

> [!warning] Exercise statements
> Always read the exercise from the rendered reader page (see `CLAUDE.md`). The PDF text layer scrambles matrix rows — e.g. 1.14's matrix comes out in the wrong row order.

## Chapter 1
**Preparation 1.1–1.4** (self-study, no key) · **Tutorial 1.5–1.16** (2026-09-01) · extra 1.17–1.19

### Answer key — Chapter 1 tutorial
| Ex | Answer |
|---|---|
| 1.5 | RREFs: $\begin{pmatrix}1&0&-14&-7\\0&1&9&2\\0&0&0&0\end{pmatrix}$ and $\begin{pmatrix}1&0&2&6\\0&1&-1&-4\\0&0&0&0\\0&0&0&0\end{pmatrix}$ |
| 1.6 | $x_1=\frac12,\ x_2=\frac32,\ x_3=\frac92$ (checked) |
| 1.7 | Inconsistent — pivot in last column (Thm 1.22) |
| 1.8 | No — the three planes have no common point |
| 1.9 | Yes: $f(x)=2x^2-7x+8$ (checked at all 4 points) |
| 1.10 | (a) No: a consistent underdetermined system always has a free variable → ∞. (b) Yes, e.g. $x_1=1,\ 2x_1=2$ |
| 1.11 | $f_1(0,0,0)=1\neq0$; linear functions map $\mathbf 0\to\mathbf 0$ |
| 1.12 | $a_{i1}x_1+\dots=(1-\lambda)b_i+\lambda b_i=b_i$ |
| 1.13a | Never none; unique for $\alpha\neq\frac12$: $x_1=-2,\ x_2=0$; ∞ for $\alpha=\frac12$ |
| 1.13b | None for $\alpha=\frac12$; unique otherwise: $x_1=\frac{7\alpha-4}{2-4\alpha},\ x_2=\frac1{2-4\alpha}$ |
| 1.13c | Always unique: $x_1=4-7\alpha,\ x_2=2-4\alpha$ |
| 1.13d | None: $\beta=3\alpha$ except $(\alpha,\beta)=(2,6),(-2,-6)$; unique: $\beta\neq3\alpha$, $x_2=\frac{\alpha\beta-12}{\beta-3\alpha}$, $x_1=-\beta-4x_2$; ∞: $(2,6)$ or $(-2,-6)$ |
| 1.14 | $A=\begin{pmatrix}-2&5&4\\1&-2&-3\\-1&3&1\end{pmatrix}$. (a) echelon form has no pivot in last row. (b) consistent iff $b_1+b_2-b_3=0$ (checked: $(1,1,-1)$ kills every column) |
| 1.15 | (a) consistent if $\alpha\neq14$, or $\alpha=14,\beta=2$. (b) $x_1=1-11x_3,\ x_2=2x_3,\ x_3$ free. (c) $\alpha\neq14$ |
| 1.16 | (a) $\left(\begin{smallmatrix}1&-2&-3&1&3\\0&0&1&\alpha&-2\\0&0&0&\alpha+1&\beta-4\end{smallmatrix}\right)$. (b) consistent if $\alpha\neq-1$, or $\alpha=-1,\beta=4$. (c) $x_1=-3+2x_2+2x_4,\ x_3=-2+x_4$, $x_2,x_4$ free |
| 1.17 | $(\frac35,\frac25)$ (checked) |
| 1.18 | $x_1=\frac53-\frac53x_3,\ x_2=\frac13-\frac13x_3$, $x_3$ free — a line (checked) |
| 1.19 | $(2,0,-1)$ (checked) |

### Ethan's worked exercises — Chapter 1
| Date | Ex | Result | Notes |
|---|---|---|---|
| | | | |

## Chapter 2
**Preparation 2.1–2.5** (self-study, no key) · **Tutorial 2.6–2.18** (2026-09-15) · extra 2.19–2.20

### Self-study 2.1 — worked and verified (2026-09-15)

> [!warning] The extracted text scrambles these vectors
> The page (printed p. 36 = PDF p. 40) has **4 components** each, not 3:
> $\mathbf u=\begin{pmatrix}2\\0\\-1\\3\end{pmatrix}$, $\mathbf v=\begin{pmatrix}5\\4\\7\\-1\end{pmatrix}$, $\mathbf w=\begin{pmatrix}6\\2\\0\\9\end{pmatrix}$ — all in $\mathbb R^4$.

| Part | Answer |
|---|---|
| (a) $3(\mathbf u-7\mathbf v)$ | $\begin{pmatrix}-99\\-84\\-150\\30\end{pmatrix}$ |
| (a) $2\mathbf v-(\mathbf u+\mathbf w)$ | $\begin{pmatrix}2\\6\\15\\-14\end{pmatrix}$ |
| (b) $\mathbf x=\tfrac16(2\mathbf u-\mathbf v-\mathbf w)$ | $\begin{pmatrix}-\frac76\\-1\\-\frac32\\-\frac13\end{pmatrix}$ |

✅ Check (b): $2\mathbf u-\mathbf v+\mathbf x=7\mathbf x+\mathbf w=\left(-\frac{13}6,\ -5,\ -\frac{21}2,\ \frac{20}3\right)$ — exact fractions, 2026-09-15.

### Answer key — Chapter 2 tutorial
Given data (from the rendered page) included so answers can be checked on the spot.

| Ex | Given | Answer |
|---|---|---|
| 2.6 | $A=\left(\begin{smallmatrix}-1&3\\0&4\\-3&2\end{smallmatrix}\right)$, $B=(1\ 2\ -4)$, $C=\left(\begin{smallmatrix}0&3&-2\\4&-1&2\end{smallmatrix}\right)$ | $AB$ undefined; $BA=(11\ \ 3)$; $AC=\left(\begin{smallmatrix}12&-6&8\\16&-4&8\\8&-11&10\end{smallmatrix}\right)$; $CA=\left(\begin{smallmatrix}6&8\\-10&12\end{smallmatrix}\right)$; $BC$, $CB$ undefined (all checked) |
| 2.7 | $f=2x^2-7x+8$ through $(1,3),(2,2),(3,5),(4,12)$ | $\left(\begin{smallmatrix}1&1&1\\4&2&1\\9&3&1\\16&4&1\end{smallmatrix}\right)\left(\begin{smallmatrix}2\\-7\\8\end{smallmatrix}\right)=\left(\begin{smallmatrix}3\\2\\5\\12\end{smallmatrix}\right)$ |
| 2.8 | (c) $A=\left(\begin{smallmatrix}1&3\\2&4\end{smallmatrix}\right)$, $AB=\left(\begin{smallmatrix}2&0\\2&2\end{smallmatrix}\right)$ | (a) $5\times4$. (b) last column of $AB$ is zero ($A\mathbf 0=\mathbf 0$). (c) $B=\left(\begin{smallmatrix}-1&3\\1&-1\end{smallmatrix}\right)$ (checked) |
| 2.9 | $A$ is $4\times3$ | (a) $I_4$ with $t_{31}=2$. (b) $I_4$ with $t_{22}=3$. (c) $I_4$ rows 2↔4. (d) $\left(\begin{smallmatrix}0&0&1&0\\0&1&0&0\\1&0&0&-3\\0&0&0&1\end{smallmatrix}\right)$. (e) undo-operation $S$ gives $ST=I$ → Lemma 2.13 |
| 2.10 | Example 2.16 | multiply out, get $I$ (inverse verified in [[L02 Matrix Algebra and Inverses]], section 8) |
| 2.11 | | (a) $A(A^{-1}\mathbf b)=(AA^{-1})\mathbf b=\mathbf b$. (b) $A\mathbf v=\mathbf b\Rightarrow\mathbf v=A^{-1}A\mathbf v=A^{-1}\mathbf b$ |
| 2.12 | $A=\left(\begin{smallmatrix}1&2&3\\1&3&5\\1&3&4\end{smallmatrix}\right)$, $B=\left(\begin{smallmatrix}3&-1&-1\\-1&-1&2\\0&1&-1\end{smallmatrix}\right)$, $\mathbf b_1=(2,2,3)$, $\mathbf b_2=(3,7,4)$, $\mathbf b_3=(7,-6,4)$ | (a) $AB=I$ + Lemma 2.13. (b) $B\mathbf b_1=(1,2,-1)$, $B\mathbf b_2=(-2,-2,3)$, $B\mathbf b_3=(23,7,-10)$ (checked) |
| 2.13 | (b) $A=\left(\begin{smallmatrix}2&-8\\-1&3\end{smallmatrix}\right)$ | (a) multiply out to $I$. (b) $A^{-1}=\left(\begin{smallmatrix}-3/2&-4\\-1/2&-1\end{smallmatrix}\right)$ (checked) |
| 2.14 | $A=\left(\begin{smallmatrix}2&1&-5\\1&2&-7\\-2&-2&8\end{smallmatrix}\right)$, $B=\left(\begin{smallmatrix}2&2&1\\1&2&2\\1&1&1\end{smallmatrix}\right)$ | $A$ singular; $B^{-1}=\left(\begin{smallmatrix}0&-1&2\\1&1&-3\\-1&0&2\end{smallmatrix}\right)$ (checked) |
| 2.15 | | (a) RREF must be $I$ (else a zero row gives a bad $\mathbf b$) → invertible. (b) $A\mathbf x=\mathbf 0$ has infinitely many solutions. (c) singular ⇒ zero row ⇒ some $\mathbf b$ inconsistent; if consistent, a free variable ⇒ ∞ |
| 2.16 | | (a),(c) Lemma 2.13. (b) $A^T(A^{-1})^T=(A^{-1}A)^T=I$. (d) $(A_1\cdots A_k)^{-1}=A_k^{-1}\cdots A_1^{-1}$ |
| 2.17 | | (a) No — no zero row ⇒ (square) pivot in every column ⇒ unique. (b) no free variables ⇒ pivot in every column ⇒ (square) every row ⇒ consistent and unique |
| 2.18 | | (a) $AA^T$, $A^TA$ always; $AA$ iff square. (b) sizes needn't match and generally unequal. (c) $(ABC)^T=((AB)C)^T=C^T(AB)^T=C^TB^TA^T$. (d) induction using Lemma 2.20 |

Extra (not assigned): 2.19 (a) multiply by $A^{-1}$; (b) $B=P^{-1}AP$; (c) $X=A^{-1}(B^3)^{-1}$ (checked on random matrices); (d) $A(BC)=I$ and $(CA)B=I$ → Lemma 2.13.

### Ethan's worked exercises — Chapter 2
| Date | Ex | Result | Notes |
|---|---|---|---|
| | | | |

## Chapter 3
**Preparation 3.1–3.5** (before 2026-09-22) · **Tutorial 3.6–3.15, 3.16 a b e** (2026-09-29)
Answer key: add after rendering reader PDF p.129–136 and checking.

## Chapter 4 & 6
**Preparation 4.1–4.3, 6.1–6.3** · **Tutorial 4.4–4.6, 6.4–6.6, 6.9** (2026-10-06)

## Chapter 5
**Preparation 5.1–5.6** · **Tutorial 5.7–5.12, 5.15–5.18, 5.20 a b c** (2026-10-20)
