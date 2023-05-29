#!/bin/bash

if [[ $OSTYPE == 'linux-gnu'* ]]; then
	pacman -S kitty bat neovim btop ripgrep lua-language-server nvm fd --noconfirm
fi

if [[ $OSTYPE == 'darwin'* ]]; then
	brew install -y kitty bat neovim btop ripgrep lua-language-server nvm fd
fi

