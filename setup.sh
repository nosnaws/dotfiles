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
	gh 

ln -sf "$DOTFILES_DIR/.zshrc" ~/.zshrc

mkdir -p ~/.config/nvim
ln -sf "$DOTFILES_DIR/.config/nvim/init.lua" ~/.config/nvim/init.lua
ln -sf "$DOTFILES_DIR/.config/nvim/lazy-lock.json" ~/.config/nvim/lazy-lock.json
ln -sf "$DOTFILES_DIR/.config/nvim/colors" ~/.config/nvim/colors

mkdir -p ~/.config/ghostty
ln -sf "$DOTFILES_DIR/.config/ghostty/config" ~/.config/ghostty/config

mkdir -p ~/.claude
ln -sf "$DOTFILES_DIR/AGENTS.md" ~/.claude/CLAUDE.md
ln -sf "$DOTFILES_DIR/.agents/skills" ~/.claude/skills

mkdir -p ~/.pi/agent/extensions/command-approval
ln -sf "$DOTFILES_DIR/AGENTS.md" ~/.pi/agent/AGENTS.md
ln -sf "$DOTFILES_DIR/.agents/skills" ~/.pi/agent/skills
ln -sf "$DOTFILES_DIR/.pi/agent/settings.json" ~/.pi/agent/settings.json
ln -sf "$DOTFILES_DIR/.pi/agent/extensions/command-approval/index.ts" ~/.pi/agent/extensions/command-approval/index.ts
ln -sf "$DOTFILES_DIR/.pi/agent/extensions/command-approval/rules.ts" ~/.pi/agent/extensions/command-approval/rules.ts
ln -sf "$DOTFILES_DIR/.pi/agent/extensions/command-approval/defaults.ts" ~/.pi/agent/extensions/command-approval/defaults.ts

