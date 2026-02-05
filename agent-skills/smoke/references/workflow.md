# Smoke Workflow Reference

## Starting a Stack

```bash
git checkout -b my-feature main
# make changes
git commit -m "Add user model"
# make more changes
git commit -m "Add user API endpoint"
# make more changes
git commit -m "Add user tests"

smoke push   # Creates 3 PRs: #1 ready, #2 draft, #3 draft
```

## Checking Status

```bash
smoke        # Shows each commit with PR number, state, and CI status
```

Output example:
```
abc1234 Add user model          PR #1 (ready) ✓
def5678 Add user API endpoint   PR #2 (draft) ○
ghi9012 Add user tests          PR #3 (draft) -
```

CI indicators: `✓` success, `✗` failure, `○` pending, `-` no checks.

## After a PR Merges

```bash
smoke pull   # Rebases onto updated main, drops merged commit, promotes next PR
```

This detects that PR #1 was squash-merged, removes it from the stack, rebases the remaining commits, and marks PR #2 as ready.

## Amending a Commit

```bash
smoke amend  # Presents numbered list, pick which commit to edit
```

Opens your editor for the selected commit. After saving, smoke rebases the rest of the stack on top.

## Getting PR URLs

```bash
smoke url    # All URLs
smoke url 2  # Just the second commit's PR URL
```

## Edge Cases

### Rebase Conflicts
If `smoke pull` hits a conflict during rebase, it reports the error and stops. Resolve the conflict manually with `git rebase --continue`, then run `smoke push` to update PR branches.

### Closed (Not Merged) PRs
If a PR was closed without merging and the commit still exists in the stack, `smoke push` will reopen it.

### Clean Working Tree Required
`smoke push`, `smoke pull`, and `smoke amend` all require a clean working tree. Stash or commit changes first.

### Branch Naming
Smoke creates remote branches as `smoke/<your-branch>/<patch-id-prefix>` for each commit's PR.

### State File
`.smoke/state.json` is created at repo root. Add `.smoke/` to `.gitignore` if you don't want it tracked.
