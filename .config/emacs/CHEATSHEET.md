# Emacs Cheat Sheet

## Concepts

| Term | Meaning |
|---|---|
| **Buffer** | An open file (or scratch space). Like a tab, but not tied to a window. |
| **Window** | A pane displaying a buffer. You can have multiple windows in one frame. |
| **Frame** | What most apps call a "window" — the OS-level Emacs window. |
| **Minibuffer** | The input bar at the bottom. Used for commands, search, file paths. |
| **Mode** | A set of behaviors for a buffer type (e.g. `go-ts-mode`, `org-mode`). |
| **Major mode** | The primary mode for a buffer (one at a time). |
| **Minor mode** | Additive modes layered on top (e.g. `evil-mode`, `lsp-mode`). |

---

## Escape Hatches

| Key | Action |
|---|---|
| `ESC` / `C-g` | Cancel whatever is happening. Reach for this when lost. |
| `C-x C-c` | Quit Emacs (prompts to save) |
| `SPC q q` | Save and quit |

---

## Evil Mode (Vim Keys)

This config uses Evil, so most Vim muscle memory works.

| Mode | How to enter |
|---|---|
| **Normal** | `ESC` |
| **Insert** | `i`, `a`, `o`, `O` |
| **Visual** | `v` (char), `V` (line), `C-v` (block) |
| **Visual** → normal | `ESC` |

### Motion (Normal mode)
| Key | Action |
|---|---|
| `h j k l` | ← ↓ ↑ → |
| `w / b` | next / prev word |
| `e` | end of word |
| `0 / $` | start / end of line |
| `gg / G` | top / bottom of file |
| `C-d / C-u` | half-page down / up |
| `{ / }` | prev / next empty line |
| `% ` | jump to matching bracket |
| `* / #` | search word under cursor forward / back |

### Editing (Normal mode)
| Key | Action |
|---|---|
| `d w` | delete word |
| `d d` | delete line |
| `y y` | yank (copy) line |
| `p / P` | paste after / before |
| `u` | undo |
| `C-r` | redo |
| `c i w` | change inner word |
| `c i "` | change inside quotes |
| `g c c` | comment line (evil-commentary) |
| `g c` (visual) | comment selection |
| `y s w "` | surround word with `"` (evil-surround) |
| `d s "` | delete surrounding `"` |
| `c s " '` | change surrounding `"` to `'` |

### Search / Replace
| Key | Action |
|---|---|
| `/` | search forward |
| `?` | search backward |
| `n / N` | next / prev match |
| `:%s/old/new/g` | replace all in file |

---

## SPC Leader Keys

### Files
| Key | Action |
|---|---|
| `SPC f f` | Find / open file |
| `SPC f r` | Recent files |
| `SPC f s` | Save buffer |
| `SPC f e` | Open emacs config dir |

### Buffers
| Key | Action |
|---|---|
| `SPC b b` | Switch buffer |
| `SPC b k` | Kill (close) buffer |
| `SPC b n / p` | Next / prev buffer |

### Windows
| Key | Action |
|---|---|
| `SPC w v` | Split vertically |
| `SPC w s` | Split horizontally |
| `SPC w h/j/k/l` | Navigate windows |
| `SPC w d` | Close window |
| `SPC w o` | Close all other windows |

### Search
| Key | Action |
|---|---|
| `SPC s s` | Search in buffer (live) |
| `SPC s r` | Ripgrep across project |

### Project
| Key | Action |
|---|---|
| `SPC p p` | Switch project |
| `SPC p f` | Find file in project |
| `SPC p s` | Search in project |
| `SPC p k` | Kill all project buffers |

### Git
| Key | Action |
|---|---|
| `SPC g g` | Open Magit |
| `SPC g b` | Git blame |

### LSP
| Key | Action |
|---|---|
| `SPC l d` | Go to definition |
| `SPC l R` | Find references |
| `SPC l i` | Go to implementation |
| `SPC l r` | Rename symbol |
| `SPC l a` | Code action |
| `SPC l f` | Format buffer |

### Open
| Key | Action |
|---|---|
| `SPC o d` | Open Dired (file browser) |

### Help
| Key | Action |
|---|---|
| `SPC h f` | Describe function |
| `SPC h v` | Describe variable |
| `SPC h k` | Describe key binding |
| `SPC h m` | Describe current mode |

### AI
| Key | Action |
|---|---|
| `SPC a g` | gptel menu |
| `SPC a s` | gptel send |
| `SPC a c` | Claude Code IDE |

---

## Common Workflows

### Open a file
1. `SPC f f` — pick any file by path
2. `SPC f r` — pick from recently opened files
3. `SPC p f` — pick a file within the current project (fastest for project work)

### Switch to a different project
1. `SPC p p` — opens a list of known projects
2. Select one — Projectile switches context
3. `SPC p f` — now find files within that project

### Add a new project
Projectile discovers projects automatically from git repos. Just open any file inside a git repo (`SPC f f`) and Projectile will register it. After that it appears in `SPC p p`.

To manually add a directory: `M-x projectile-add-known-project`

### Open and edit an Org file
1. `SPC f f` → navigate to a `.org` file (or create one, e.g. `~/org/notes.org`)
2. Emacs automatically enters `org-mode` for `.org` files
3. Start typing — use `*` at the start of a line for headings

### Create a new file
1. `SPC f f` — type the full path including the new filename
2. Emacs will ask to create it — confirm
3. `SPC f s` to save

### Split and navigate panes
1. `SPC w v` — split vertically (side by side)
2. `SPC w s` — split horizontally (top/bottom)
3. `SPC w h/j/k/l` — move between panes
4. `SPC w d` — close current pane

### Search across a project
- `SPC s r` — ripgrep across the whole project, results update live
- Type to filter, `RET` to jump to a match

### Rename a symbol (LSP)
1. Place cursor on the symbol
2. `SPC l r` — type the new name, `RET`
3. Renames all references across the project

### Toggle light / dark theme manually
```
M-x load-theme RET ef-day RET      ← light
M-x load-theme RET ef-dream RET    ← dark
```

---

## Dired (File Browser)

Open with `SPC o d`. Navigate with Evil keys.

| Key | Action |
|---|---|
| `RET` | Open file / enter directory |
| `^` | Go up to parent directory |
| `TAB` | Expand directory inline (dired-subtree) |
| `d` | Mark for deletion |
| `x` | Execute deletions |
| `R` | Rename / move file |
| `C` | Copy file |
| `+` | Create directory |
| `q` | Quit Dired |

---

## Magit

Open with `SPC g g`.

| Key | Action |
|---|---|
| `s` | Stage file / hunk |
| `u` | Unstage file / hunk |
| `c c` | Commit (opens message buffer) |
| `C-c C-c` | Confirm commit message |
| `P p` | Push |
| `F p` | Pull |
| `b b` | Switch branch |
| `b c` | Create branch |
| `l l` | View log |
| `d d` | Diff file |
| `TAB` | Expand / collapse section |
| `q` | Quit Magit |

---

## Org Mode

Any file ending in `.org` opens in Org mode automatically.

### Structure
```
* Top-level heading
** Sub-heading
*** Sub-sub-heading
- bullet point
  - nested bullet
```

### Keys
| Key | Action |
|---|---|
| `TAB` | Fold / unfold heading |
| `S-TAB` | Fold / unfold everything |
| `C-RET` | New heading at same level |
| `M-RET` | New item / heading |
| `M-↑ / M-↓` | Move heading up / down |
| `M-→ / M-←` | Demote / promote heading |
| `C-c C-l` | Insert link |
| `C-c C-o` | Open link under cursor |
| `C-c C-t` | Cycle TODO state (TODO → DONE → none) |
| `C-c '` | Edit code block in dedicated buffer |

### Text formatting
```
*bold*   /italic/   _underline_   ~code~   =verbatim=
```
(Markers are hidden by default — `org-hide-emphasis-markers` is on)

---

## Completion (Corfu + Vertico)

| Key | Action |
|---|---|
| (just type) | Corfu popup appears automatically |
| `TAB` | Accept completion |
| `RET` | Accept completion |
| `ESC` | Dismiss popup |
| (in minibuffer) | Vertico shows candidates as you type |
| `C-n / C-p` | Navigate candidates |

---

## Misc

| Key | Action |
|---|---|
| `SPC SPC` | M-x (run any command by name) |
| `SPC :` | Eval Elisp expression |
| `C-x C-f` | Find file (classic Emacs binding) |
| `C-x k` | Kill buffer (classic) |
| `C-x 2` | Split horizontally (classic) |
| `C-x 3` | Split vertically (classic) |
| `C-x o` | Cycle windows (classic) |
| `M-x` | Run command (classic) |

---

## Build / Test / Run Commands

Emacs doesn't have a built-in "run config" like an IDE. The standard approach is `M-x compile` which runs any shell command and captures output in a buffer with clickable error links.

### compile (the universal approach)

| Key / Command | Action |
|---|---|
| `M-x compile` | Run a build/test command (prompts for command) |
| `M-x recompile` | Re-run the last compile command |
| `g` (in compile buffer) | Re-run the command |
| `C-x `` ` | Jump to next error in source |
| `q` | Close compile buffer |

First time: `M-x compile` → type your command e.g. `go test ./...` or `npm test`. Emacs remembers it per-project. After that, `M-x recompile` (or bind it) re-runs without prompting.

### Projectile shortcuts

Projectile has built-in slots for project commands — set them once per project:

| Command | Action |
|---|---|
| `M-x projectile-configure-project` | Set configure command |
| `M-x projectile-compile-project` | Run compile command |
| `M-x projectile-test-project` | Run test command |
| `M-x projectile-run-project` | Run the project |

Set defaults in your config by adding to `projects.el`:
```elisp
(setq projectile-project-compilation-cmd "make build"
      projectile-project-test-cmd "make test"
      projectile-project-run-cmd "make run")
```

Or use a `.dir-locals.el` file at the project root for per-project overrides:
```elisp
;; .dir-locals.el
((nil . ((projectile-project-test-cmd . "go test ./...")
         (projectile-project-run-cmd  . "go run main.go"))))
```

### Per-language conventions

| Language | Typical compile command |
|---|---|
| Go | `go build ./...` / `go test ./...` |
| TypeScript | `npx tsc --noEmit` / `npm test` |
| Python | `python -m pytest` |
| Make | `make` / `make test` / `make run` |

> **Tip:** The compile buffer highlights errors and links them to source lines. Press `RET` on an error to jump directly to it.

---

> **Tip:** Press `SPC` and wait — which-key will show all available bindings.
