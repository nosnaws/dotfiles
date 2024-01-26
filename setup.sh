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


mkdir -p ~/.config/nvim
ln -f ./.config/nvim/init.lua ~/.config/nvim/init.lua
ln -f ./.config/nvim/lazy-lock.json ~/.config/nvim/lazy-lock.json

mkdir -p ~/.config/alacritty
ln -f ./.config/alacritty/alacritty.toml ~/.config/alacritty/alacritty.toml

mkdir -p ~/.config/alacritty/themes
gh repo clone EdenEast/nightfox.nvim ~/.config/alacritty/themes/
