# SKILL.md
---
name: smoke
description: Use when managing stacked diffs, creating PR stacks, rebasing stacks onto main, or amending commits in a stack. Applies to any workflow involving multiple commits that each need their own PR.
---

## Smoke — Stacked Diffs CLI

Manages a stack of commits as individual PRs with squash-merge workflows.

### Model

Single branch, N commits ahead of `main`. Each commit = one PR. Only the bottom PR is ready for review; the rest are drafts.

```
main
 └── commit A  →  PR #1 (ready)
      └── commit B  →  PR #2 (draft)
           └── commit C  →  PR #3 (draft)
```

### Commands

| Command         | What it does                                              |
|-----------------|-----------------------------------------------------------|
| `smoke`         | Show stack status — commits, PRs, CI checks, draft state  |
| `smoke push`    | Create or update a PR for each commit in the stack        |
| `smoke pull`    | Fetch main, rebase stack, update PR draft states          |
| `smoke amend`   | Interactively pick a commit to amend, then rebase         |
| `smoke url [N]` | Show PR URLs (all, or position N)                         |
| `smoke help`    | Print usage                                               |

### Typical Workflow

1. **Start a feature branch** and make commits — one per logical change.
2. `smoke push` — creates PRs for each commit.
3. Reviewer merges the bottom PR (squash-merge).
4. `smoke pull` — rebases onto updated main, promotes next PR to ready.
5. Repeat until stack is empty.

### Amending Mid-Stack

`smoke amend` lets you pick any commit in the stack to edit. After amending, smoke rebases the remaining commits on top automatically.

### State

Stored in `.smoke/state.json` at repo root. Each commit gets a dedicated remote branch (`smoke/<branch>/<position>`) used as the PR head. Patch IDs are used internally to match commits across rebases — no commit message modification needed.

### Key Behaviors

- Uses `--force-with-lease` for safe force-pushes (falls back to `--force` for new branches).
- Detects merged/closed PRs and cleans up state.
- Reopens closed PRs if the commit still exists in the stack.
- Requires a clean working tree before `push`, `pull`, or `amend`.

### Requirements

- `git` on PATH
- `gh` CLI authenticated with GitHub

### Reference

See [full workflow details](references/workflow.md) for edge cases and troubleshooting.
