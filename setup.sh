#!/bin/sh

PWD=$(pwd)

ln -fs $PWD/.gitconfig $HOME/.gitconfig
ln -fs $PWD/config/kitty $HOME/.config/
ln -fs $PWD/config/nvim $HOME/.config/


# Install dependecies
source ./install.sh
