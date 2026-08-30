# Study Folder Reorganisation + Work Folder

Date: 2026-08-30
Status: Approved

## Problem

`~/study` is a single git repo (~3 GB working tree, 357 MB `.git`) inside a
Syncthing share. It has accumulated four distinct problems:

1. **Unsortable term names.** `q3y1`, `q1y2`, `q2y2`, `q3y2` sort
   quarter-first, so `q1y2` precedes `q3y1` and chronology is scrambled.
2. **Mixed domains at root.** Coursework, self-directed projects, course
   reference material and stray files are all peers.
3. **Committed build artifacts.** `.gitignore` covers `**/build/` but not
   `bin/`, `obj/` or `node_modules/`, so .NET output and npm trees entered
   history. The ten largest blobs are all build output.
4. **Two stalled edits.** A `library_ec11` move was never committed, and
   `.gitmodules` points at `LoRa-mesh/MeshCore-MKRWAN1310D` while the folder
   on disk is `MeshCore-MKRWAN1310`.

A work folder is also needed for a new job starting alongside year 3.

## Decisions

| Decision | Choice | Rationale |
|---|---|---|
| Term naming | Calendar year, quarter inside | Sorts chronologically; groups a year's work together |
| Work location | `study/work/`, git-ignored, own repo | One place to look; employer code stays out of personal history |
| Projects | Single top-level `projects/` | Survives year rollover; active work stays findable |
| Git history | Stop the bleeding, do not rewrite | Avoids force-push and a Syncthing-vs-rewrite race |

Academic-year mapping assumed: year 1 = 2024-2025, year 2 = 2025-2026,
new year 3 = 2026-2027. Git dates cannot confirm this (the repo begins with
a bulk import on 2026-03-09); confirmed verbally by the user.

## Target layout

```
study/
├── 2024-2025/q3/                 <- q3y1
├── 2025-2026/
│   ├── q1/                       <- q1y2 (minus project/)
│   ├── q2/                       <- q2y2
│   └── q3/                       <- q3y2
│       └── SSP-examples/         <- SSP-Example-Bak
├── 2026-2027/q1/                 <- new scaffold
├── projects/
│   ├── LoRa-mesh/  tradingbot/  nansen_copytrade/
│   ├── dasaimochirpi/  library_ec11/
│   ├── learnreact/  python-podomoro/  RevisitPython/
│   └── calculator.py
└── work/                         <- git-ignored, own repo
```

`SSP-Example-Bak` is teacher-supplied material for the year-2 q3 SSP course,
so it belongs under that term rather than under `projects/`.

## Work folder

```
work/
├── README.md      employer, role, start date, links
├── onboarding/    accounts, dev-env setup, who's who
├── projects/      one folder per work project
├── notes/         YYYY-MM-DD meeting notes
└── admin/         contract, hours, invoices  (git-ignored)
```

Ignored from the study repo via `/work/`, with its own `git init` so histories
stay independent. `admin/` is additionally ignored inside `work/` because
contracts and payslips should not enter any repo.

Caveat accepted by the user: `work/` still replicates via Syncthing, since
Syncthing shares the directory irrespective of git.

## Git remediation

- Extend `.gitignore`: `bin/`, `obj/`, `node_modules/`, `*.zip`, `/work/`
- `git rm -r --cached` tracked artifacts; history untouched, no force-push
- Repoint the `.gitmodules` submodule path to `projects/LoRa-mesh/MeshCore-MKRWAN1310`
- Commit the stalled `library_ec11` move as part of the reorg

Branch `y2q1` is retained: it is unmerged and carries one unique commit on a
divergent root.

## Deletions (user-approved)

- `Saxion/` — verified empty
- `python main.py` — truncated tail of the complete `python-podomoro/README.md`
- `library_ec11(1).zip` — superseded by `projects/library_ec11/`
- `.aider.chat.history.md`, `.aider.input.history`, `.aider.tags.cache.v4/`

## Out of scope

Folder-name typos (`microcontroler`, `FuctionalHWD`, `HOMEGOUP`) are left as-is.

## Safety

- Syncthing paused before execution (confirmed by user)
- Backup branch `backup/pre-reorg-2026-08-30` at `71a240f8`
- All moves via `git mv` to preserve history
- Obsidian: 280 markdown files, only 2 use wikilinks and both resolve within
  their own assignment folder, so link breakage is negligible
