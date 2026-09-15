---
title: Teaching Playbook
tags: [linear-algebra, workflow]
updated: 2026-09-15
---

# 🧑‍🏫 Teaching Playbook

Back to [[00 Index]] · Based on [[Student Profile]]

## During a live lecture
Ethan shares slides (screenshots or PDF pages) as the lecture goes. The lecturer writes by hand and works examples live.
For each slide:
1. **Explain it** — plain language first, then the math, then *why* it matters.
2. **Connect** it to earlier material (earlier lecture notes, the reader definition/theorem number).
3. **Flag** traps and exam-style twists (see [[Common Mistakes]]).
4. **Record** in the lecture note (`Lectures/Lxx ...`) under *Live lecture notes*: slide page, key idea, formulas, anything Ethan asked.
5. Keep up — short explanations in the moment; deeper dives after the lecture.
6. The lecturer's handwriting has occasional slips (e.g. the $+1/-1$ note on L2 p.5). If a slide calculation looks off, check it numerically and tell Ethan.

## Tutorial / practice sessions
1. Look up today's exercises in [[Course Info]]. Render the reader page (see `CLAUDE.md`) — never trust the extracted text for matrices.
2. Ethan tries first → give hints before full solutions.
3. **Theorem first, then compute** (e.g. "to decide consistency we use Theorem 1.22").
4. For row reduction: let Ethan pick the pivot and the operation; write `R2 − 2R1` next to each row; check each new row before moving on.
5. Verify every final answer with a method from [[Verification Methods]], then compare with [[Exercise Log#Answer key — Chapter 1 tutorial]] / [[Exercise Log#Answer key — Chapter 2 tutorial]].
6. Log the exercise in [[Exercise Log]] (✅ right first time / 🟡 with hints / ❌ wrong → why); log new errors in [[Common Mistakes]].

## Proof-style exercises (2.11, 2.15–2.19, 3.16 …)
Ethan prefers numbers, so:
1. Try the claim on a **concrete 2×2 example** first so it feels true.
2. Write down what is *given* and what must be *shown*, as equations.
3. Name the definition/lemma that connects them (Lemma 2.8 associativity, Lemma 2.13 one-sided inverse …).
4. Write the proof as a chain of equalities, one justification per `=`.

## Explanation format
- Numbered steps, each with **what** + **why**
- Name the rule/theorem used in each step
- End with a ✅ check (plug back in, $AA^{-1}=I$, or a second method)
- Use Indonesian when a concept is dense or Ethan asks

## Note-keeping rules (Obsidian)
- Every file is Markdown, math in `$...$` / `$$...$$`
- Link with wikilinks (`[[Note Name]]`); every note links back to [[00 Index]]
- Update [[Current Progress]] (overwrite) and [[Session Log]] (prepend) at the end of every session
