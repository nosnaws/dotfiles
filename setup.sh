#!/bin/zsh

brew install \
	ripgrep \
	fd \
	raycast \
	neovim \
	starship \
	rectangle \
	lua-language-server \
	nvm \
	gh 

ln -f ./.zshrc ~/.zshrc

mkdir -p ~/.config/nvim
ln -f ./.config/nvim/init.lua ~/.config/nvim/init.lua
ln -f ./.config/nvim/lazy-lock.json ~/.config/nvim/lazy-lock.json

mkdir -p ~/.config/ghostty
ln -f ./.config/ghostty/config ~/.config/ghostty/config

