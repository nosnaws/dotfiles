#!/bin/bash

if [[ $OSTYPE == 'linux-gnu'* ]]; then
	pacman -S kitty bat neovim btop ripgrep lua-language-server nvm --noconfirm
fi

if [[ $OSTYPE == 'darwin'* ]]; then
	brew install -y kitty bat neovim btop ripgrep lua-language-server nvm
fi

# Plugin management for neovim
curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
