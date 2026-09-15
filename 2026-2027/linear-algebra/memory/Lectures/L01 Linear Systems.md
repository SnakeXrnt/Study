---
title: "Lecture 1 — Linear Systems and Gauss-Jordan Elimination"
lecture: 1
chapter: 1
date: 2026-08-31
slides: ../../lectures_slides/Linear-Algebra-Lecture1.pdf
reader: "Ch 1, printed p.1–22 (PDF p.5–26)"
tags: [linear-algebra, lecture, linear-systems, row-reduction]
status: lectured
updated: 2026-09-15
---

# Lecture 1 — Linear Systems and Gauss-Jordan Elimination

Back to [[00 Index]] · Next: [[L02 Matrix Algebra and Inverses]]
Procedure sheet: [[Row Reduction Algorithm]] · Practice: [[Exercise Log#Chapter 1]]

> [!abstract] Big picture
> Many problems give several equations in several unknowns. When every equation is **linear** (unknowns only multiplied by constants and added), there is a complete, mechanical method to find **all** solutions: write the system as a matrix and **row reduce** it. Linear algebra always asks two questions:
> 1. Does a solution **exist**? (consistent or not)
> 2. If yes, is it **unique**, or are there infinitely many?

## 1. Motivating example — mixing acid (slide p.1–2)
Three solutions contain 10 %, 20 % and 40 % HCl. Can we make 100 L of 25 % HCl? Let $x_1,x_2,x_3$ = litres of each.
$$\begin{cases} x_1+x_2+x_3=100 & \text{(total volume)}\\ \frac{10}{100}x_1+\frac{20}{100}x_2+\frac{40}{100}x_3=25 & \text{(litres of pure HCl)}\end{cases}$$
Substitution: $x_1=100-x_2-x_3$ into (2) gives $\frac{10}{100}x_2+\frac{30}{100}x_3=15$, so $x_2=150-3x_3$ and $x_1=-50+2x_3$.
Physical constraint $x_i\ge0$: $x_1\ge0\Rightarrow x_3\ge25$; $x_2\ge0\Rightarrow x_3\le50$.
**Any $25\le x_3\le50$ works → infinitely many recipes.** (Check $x_3=25$: $(0,75,25)$ → $15+10=25$ ✓)

> [!tip] Engineering view
> Two constraints, three knobs → one knob ($x_3$) is left free. That "free knob" is exactly a **free variable**.

## 2. Vocabulary (slide p.1–2 · reader §1.2)
- **Linear equation:** $a_1x_1+a_2x_2+\dots+a_nx_n=b$ — $a_i$ are **coefficients** (known numbers), $x_i$ **unknowns**, $b$ constant. (Reader Def 1.2: $f$ is linear if $f(x+\alpha y)=f(x)+\alpha f(y)$.) $(x_1-1)^2+x_2^2=5$ is **not** linear.
- **Linear system:** several linear equations in the same unknowns — $m$ equations, $n$ unknowns (reader (1.5)).
- **Solution:** numbers $s_1,\dots,s_n$ that satisfy **every** equation. **Solution set:** the set of all solutions (Def 1.9).
- **Consistent:** at least one solution. **Inconsistent:** none (Def 1.8).

> [!important] Important Fact 1 (reader Theorem 1.11)
> A linear system has **0, 1, or infinitely many** solutions — never exactly 2.
> *Why:* if $u$ and $v$ are two different solutions, then $u+\lambda(v-u)$ is a solution for **every** $\lambda\in\mathbb R$ (plug in: $(1-\lambda)b_i+\lambda b_i=b_i$). Exercise 1.12.

Geometrically: one equation in 2 unknowns = a line in $\mathbb R^2$; in 3 unknowns = a plane in $\mathbb R^3$ (Example 1.10). Solving a system = intersecting lines/planes.

## 3. Three possible outcomes — the 2×2 examples (slide p.3, p.5–6 · reader Ex 1.5–1.7)
| System | Outcome | Picture |
|---|---|---|
| $3x_1+x_2=1,\ 2x_1+x_2=0$ | unique: $x_1=1,\ x_2=-2$ | two lines cross once |
| $3x_1+x_2=1,\ 6x_1+2x_2=2$ | infinitely many: $x_2=1-3x_1$, $x_1$ free | same line twice |
| $3x_1+x_2=1,\ 6x_1+2x_2=3$ | none: leads to $0=1$ (or "$2=3$" on the slide) | parallel lines |

## 4. Matrices as shorthand (slide p.3 · reader §1.2, §1.3)
- **Coefficient matrix** $A$: row $i$ = equation $i$, column $j$ = unknown $x_j$. Size **$m\times n$ = rows × columns**. The acid system: $\begin{pmatrix}1&1&1\\ \frac{10}{100}&\frac{20}{100}&\frac{40}{100}\end{pmatrix}$ is $2\times3$.
- **Augmented matrix** $(A\mid b)$: add the right-hand sides as a last column:
$$\left(\begin{array}{ccc|c}1&1&1&100\\ \frac{10}{100}&\frac{20}{100}&\frac{40}{100}&25\end{array}\right)$$
- The whole system is written $A\mathbf x=\mathbf b$ (product defined in [[L02 Matrix Algebra and Inverses]]).

## 5. Elementary row operations (slide p.4 · reader Def 1.12–1.13)
1. **Add a multiple** of one row to another row
2. **Multiply** a row by a number $\neq0$
3. **Interchange** two rows

They **do not change the solution set** (each can be undone). Matrices that can be turned into each other this way are **row equivalent**, written $\sim$.

Slide p.4 on the acid system: $R_2\times10$, then $R_2-R_1$:
$$\left(\begin{array}{ccc|c}1&1&1&100\\1&2&4&250\end{array}\right)\sim\left(\begin{array}{ccc|c}1&1&1&100\\0&1&3&150\end{array}\right)$$

## 6. Pivots, echelon form, reduced echelon form (slide p.4–5 · reader Def 1.18, Thm 1.20)
- **Pivot:** first nonzero entry of a nonzero row.
- **Echelon form:** (1) zero rows at the bottom; (2) each pivot is strictly **to the right** of the pivot above it ("staircase").
- **Reduced echelon form (RREF):** echelon form **and** every pivot is $1$ **and** is the only nonzero entry in its column.
- Every matrix can be row reduced to (reduced) echelon form. **RREF is unique; echelon form is not.** (Theorem 1.20)

Acid system, one more step $R_1-R_2$:
$$\left(\begin{array}{ccc|c}1&0&-2&-50\\0&1&3&150\end{array}\right)\ \leftarrow\text{RREF}$$

## 7. Reading the answer: basic and free variables (slide p.5 · reader Ex 1.24)
- Columns **with** a pivot → **basic variables**. Columns **without** a pivot → **free variables**.
- Write each basic variable in terms of the free ones = **parametric description** of the solution set:
$$x_1=2x_3-50,\qquad x_2=150-3x_3,\qquad x_3\ \text{free}$$

> [!important] Important Fact 2 (reader Theorem 1.22)
> $A\mathbf x=\mathbf b$ is **consistent** $\iff$ the (reduced) echelon form of the augmented matrix has **no pivot in the last column**.
> A pivot in the last column means a row $(0\ 0\ \cdots\ 0\mid c)$ with $c\neq0$, i.e. the equation $0=c$.

Slide p.6, the inconsistent example: $\left(\begin{array}{cc|c}3&1&1\\6&2&3\end{array}\right)\xrightarrow{R_1\times2}\left(\begin{array}{cc|c}6&2&2\\6&2&3\end{array}\right)\xrightarrow{R_2-R_1}\left(\begin{array}{cc|c}6&2&2\\0&0&1\end{array}\right)$ → pivot in last column → **no solution**.

### Decision table (from Thm 1.22 + free variables)
| Echelon form of $(A\mid b)$ | Number of solutions |
|---|---|
| pivot in the last column | **0** (inconsistent) |
| no pivot in last column, every variable column has a pivot | **1** |
| no pivot in last column, at least one variable column without pivot | **∞** (one parameter per free variable) |

## 8. The algorithm in the reader (§1.3, steps i–v)
Full version with tips: [[Row Reduction Algorithm]].
1. Leftmost nonzero column; swap a nonzero entry to the top (prefer a $1$) → pivot.
2. Add multiples of the top row to make everything **below** the pivot $0$.
3. Cover the top row, repeat on the rest → **echelon form**.
4. Scale each pivot row so the pivot is $1$.
5. From the bottom up, clear everything **above** each pivot → **RREF**.

Reader Example 1.16/1.17 (worth re-doing by hand): $2x_1-x_2+x_3-x_4=-6,\ -x_1+x_2+5x_3+2x_4=2,\ 2x_1-x_2+2x_3-3x_4=3$ → $x_1=-13x_4-58,\ x_2=-25x_4-101,\ x_3=2x_4+9,\ x_4$ free.

## 9. Systems with parameters (reader Example 1.25) — exam favourite
$\alpha x_1+(\alpha+1)x_2+\alpha x_3=\beta+2,\ 2x_1+4x_2+\alpha x_3=\beta+5,\ x_1+2x_2+x_3=2$.
- **Don't** divide by $\alpha$ (it might be $0$). **Swap** so a row starting with $1$ is on top.
- Reduce to echelon form: $\left(\begin{array}{ccc|c}1&2&1&2\\0&1-\alpha&0&\beta+2-2\alpha\\0&0&\alpha-2&\beta+1\end{array}\right)$
- Split cases where a would-be pivot is $0$: $\alpha=1$ and $\alpha=2$.
- Result: consistent **except** when $\alpha=1,\beta\neq0$ or $\alpha=2,\beta\neq-1$.

> [!warning] Traps
> - Apply each row operation to the **whole** row, including the augmented column.
> - A zero **row** $(0\cdots0\mid0)$ is harmless; $(0\cdots0\mid c\neq0)$ is the contradiction.
> - Never multiply a row by $0$ (not an elementary operation) and don't divide by an expression that might be $0$.
> - Underdetermined (fewer equations than unknowns) can **never** have a unique solution; overdetermined **can** (Exercise 1.10).

## Exercises for this chapter
- Preparation (before 2026-08-31): **1.1–1.4** (self-study, no answer key)
- Tutorial (2026-09-01): **1.5–1.16** (answers in [[Exercise Log#Answer key — Chapter 1 tutorial]]); 1.17–1.19 extra

## 📝 Live lecture notes — 2026-08-31
*(Lecture was before this vault existed. Add anything Ethan remembers or asks about here.)*
