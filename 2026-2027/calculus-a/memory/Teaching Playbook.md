---
title: Teaching Playbook
tags: [calculus-a, workflow]
updated: 2026-09-16
---

# 🧑‍🏫 Teaching Playbook

Back to [[00 Index]] · Based on [[Student Profile]]

## During a live lecture
Ethan shares slides (screenshots or PDF pages) as the lecture goes.
For each slide:
1. **Explain it** — plain language first, then the math, then *why* it matters.
2. **Connect** it to what Ethan already knows (link to earlier lectures).
3. **Flag** traps and exam-style twists.
4. **Record** in the lecture note (`Lectures/Lxx ...`) under *Live lecture notes*: slide number, key idea, formulas, anything Ethan asked.
5. Keep up — short explanations in the moment; deeper dives after the lecture.

## Practice / exercise sessions
1. Ethan tries first → give hints before full solutions.
2. **Rule first, then substitute** (name the rule, write the general form).
3. Verify every final answer with at least one method from [[Verification Methods]].
4. Log the exercise and answer in [[Exercise Log]]; log new errors in [[Common Mistakes]].

## Explanation format
> [!important] Plain text in chat — no LaTeX
> Ethan reads the chat in a terminal, so `$...$` math does not render and he cannot read it.
> Write `a/b`, `s^(-3/2)`, `sqrt(2)`, `integral from 1 to sqrt(2) of (s^2 + sqrt(s))/s^2 ds`.
> Markdown headings, tables and bold are fine. LaTeX belongs **only** in these Obsidian notes.

- Numbered steps, each with **what** + **why**
- Name the rule used in each step
- End with a ✅ check (numerical or special value)
- Use Indonesian when a concept is dense or Ethan asks

## Choosing an integration technique
Before integrating, ask out loud: **"is there something *inside* something?"**
1. **Yes** — $\cos 2x$, $(3x+1)^5$, $e^{-2x}$ → reverse Chain Rule / substitution
2. **No, it's a fraction** with a single power on the bottom → **split the fraction**, rewrite each piece as a power, then Power Rule
3. **No, it's a product of unrelated functions** → integration by parts
Make Ethan answer this question himself before any algebra happens.

## Note-keeping rules (Obsidian)
- Every file is Markdown, math in `$...$` / `$$...$$`
- Link with `[[wikilinks]]`; every note links back to [[00 Index]]
- Update [[Session Log]] at the end of every session
- Keep the original handover files unchanged
