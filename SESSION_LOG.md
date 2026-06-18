# Session Log

## 2026-06-15

### Emacs config setup

Created a full from-scratch Emacs config at `.config/emacs/`, integrated into dotfiles with symlinks in `setup.sh`.

**Stack decisions:**
- Package manager: straight.el (reproducible, lockfile-style)
- Completion UI: Vertico + Orderless + Consult + Marginalia
- In-buffer completion: Corfu + Cape
- LSP: lsp-mode + lsp-ui
- Keybindings: Evil mode (+ evil-collection, evil-surround, evil-commentary)
- Undo: undo-fu + undo-fu-session
- Keybinding framework: general.el with SPC leader (Doom-style)
- File management: Dired + dired-subtree (no sidebar tree)
- Git: Magit
- Snippets: yasnippet + yasnippet-snippets
- Theme: ef-themes (ef-day light / ef-dream dark, auto-switches with macOS appearance)
- Modeline: doom-modeline + nerd-icons
- Font: Hack at 14pt
- Languages: Go, TypeScript, Python, Bash, YAML, TOML, JSON via treesit-auto + lsp-mode
- Org: minimal org + org-modern (docs/writing use case)
- AI: gptel (note: user said "gpt.el", gptel is the MELPA package), mcp.el, claude-code.el

**Files created:**
- `.config/emacs/early-init.el` — UI chrome removal, package.el disable, GC tuning
- `.config/emacs/init.el` — straight.el bootstrap, global defaults, module loading
- `.config/emacs/lisp/core.el` — Evil, which-key, general.el, helpful, SPC keybindings
- `.config/emacs/lisp/ui.el` — ef-themes, doom-modeline, Hack font
- `.config/emacs/lisp/completion.el` — Vertico/Orderless/Consult/Marginalia, Corfu, yasnippet
- `.config/emacs/lisp/projects.el` — Projectile, Dired, Magit
- `.config/emacs/lisp/lsp-config.el` — lsp-mode, lsp-ui
- `.config/emacs/lisp/langs.el` — language modes + LSP hooks
- `.config/emacs/lisp/org-config.el` — org + org-modern
- `.config/emacs/lisp/ai.el` — gptel, mcp.el, claude-code.el

**Post-install steps (one-time):**
1. Run `M-x nerd-icons-install-fonts` after first Emacs launch
2. Install TypeScript LS: `npm install -g typescript typescript-language-server`
3. Verify claude-code.el repo in `ai.el` matches the correct upstream

### Emacs config review (findings)

Reviewed all 8 config files + setup.sh integration.

**Bugs:**
1. `core.el:141` — `SPC l e` bound to `lsp-treemacs-errors` but lsp-treemacs never installed → void-function error. Fix: add `(use-package lsp-treemacs)` or rebind.
2. `init.el:27` — `exec-path-from-shell` guarded by `(memq window-system '(mac ns x))`, nil under `emacs --daemon`. PATH + ANTHROPIC_API_KEY never load in daemon mode (config is otherwise daemon-aware). Fix: add `(daemonp)` to guard. Compounds with `ai.el:10` gptel key lookup.

**Gaps:**
3. setup.sh installs `pyright` but lsp-mode has no built-in pyright client → needs `lsp-pyright` package or switch to python-lsp-server. Python LSP won't start as-is.

**Cleanup:**
- `ai.el:1` header claims mcp.el configured; it isn't (stale comment).
- `consult-projectile` installed but never bound (projects.el:12).
- `typescript-mode` (langs.el:27) redundant — treesit-auto routes .ts → typescript-ts-mode.

Status: FIXED (2026-06-15).
- `core.el` — removed `SPC l e` lsp-treemacs binding (user doesn't use treemacs); repointed `SPC p p`/`p f` to consult-projectile commands.
- `init.el` — added `(daemonp)` to exec-path-from-shell guard.
- `langs.el` — added `lsp-pyright` package for python; removed redundant `typescript-mode` (treesit-auto handles .ts/.tsx).
- `ai.el` — corrected stale "mcp.el" header comment.
All changed files pass sexp-balance check.

## 2026-06-18

### Replaced claude-code-ide with agent-shell

Swapped `manzaltu/claude-code-ide.el` (+ `eat` dependency) for `xenodium/agent-shell` in `.config/emacs/lisp/ai.el`.

**New stack:** `agent-shell` (MELPA, `:straight t`) + ACP protocol  
**External dep required:** `npm install -g @agentclientprotocol/claude-agent-acp`  
**Auth:** login-based (reuses existing `claude` CLI session)  
**New keybindings:**
- `SPC a c` → `agent-shell-anthropic-start-claude-code`
- `SPC a t` → `agent-shell-toggle`
- `SPC a d` → `agent-shell-send-dwim` (send region or error at point)

Evil integration wired: insert-RET inserts newline, normal-RET submits; diff buffers use emacs-state.

## 2026-04-28

- Added `web-search` skill at `.agents/skills/web-search/SKILL.md`
  - Uses `ddgr` CLI tool for DuckDuckGo searches
  - Includes brew installation instructions
  - References `ddgr --help` for usage details
- Added `web-view` skill at `.agents/skills/web-view/SKILL.md`
  - Uses `lynx` CLI tool for viewing web pages
  - Includes `lynx -dump` and `lynx -dump -listonly` usage examples
  - Includes brew installation instructions
