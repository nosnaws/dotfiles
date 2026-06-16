#!/bin/zsh

DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"

brew install \
	ripgrep \
	fd \
	raycast \
  ghostty \
	neovim \
	starship \
	rectangle \
	lua-language-server \
	nvm \
	gh \
	coreutils

# Emacs
brew tap d12frosted/emacs-plus
brew install emacs-plus@30

# Language servers for Emacs LSP
brew install gopls
brew install pyright
brew install bash-language-server
# TypeScript LS requires npm — run after setting up nvm:
#   npm install -g typescript typescript-language-server

# Fonts
brew install --cask font-hack
# Nerd Icons font for doom-modeline (also run M-x nerd-icons-install-fonts once in Emacs)
brew install --cask font-symbols-only-nerd-font

ln -sfh "$DOTFILES_DIR/.zshrc" ~/.zshrc

mkdir -p ~/.config/nvim
ln -sfh "$DOTFILES_DIR/.config/nvim/init.lua" ~/.config/nvim/init.lua
ln -sfh "$DOTFILES_DIR/.config/nvim/lazy-lock.json" ~/.config/nvim/lazy-lock.json
ln -sfh "$DOTFILES_DIR/.config/nvim/colors" ~/.config/nvim/colors

mkdir -p ~/.config/ghostty
ln -sfh "$DOTFILES_DIR/.config/ghostty/config" ~/.config/ghostty/config

mkdir -p ~/.claude
ln -sfh "$DOTFILES_DIR/AGENTS.md" ~/.claude/CLAUDE.md
ln -sfh "$DOTFILES_DIR/.agents/skills" ~/.claude/skills

# Emacs — symlink into ~/.emacs.d (Emacs default, avoids XDG priority issues)
# straight/ and other generated dirs live in ~/.emacs.d/ untracked
mkdir -p ~/.emacs.d
ln -sfh "$DOTFILES_DIR/.config/emacs/early-init.el" ~/.emacs.d/early-init.el
ln -sfh "$DOTFILES_DIR/.config/emacs/init.el" ~/.emacs.d/init.el
ln -sfh "$DOTFILES_DIR/.config/emacs/lisp" ~/.emacs.d/lisp

mkdir -p ~/.pi/agent/extensions/command-approval
ln -sfh "$DOTFILES_DIR/AGENTS.md" ~/.pi/agent/AGENTS.md
ln -sfh "$DOTFILES_DIR/.agents/skills" ~/.pi/agent/skills
ln -sfh "$DOTFILES_DIR/.pi/agent/settings.json" ~/.pi/agent/settings.json
ln -sfh "$DOTFILES_DIR/.pi/agent/extensions/command-approval/index.ts" ~/.pi/agent/extensions/command-approval/index.ts
ln -sfh "$DOTFILES_DIR/.pi/agent/extensions/command-approval/rules.ts" ~/.pi/agent/extensions/command-approval/rules.ts
ln -sfh "$DOTFILES_DIR/.pi/agent/extensions/command-approval/defaults.ts" ~/.pi/agent/extensions/command-approval/defaults.ts

