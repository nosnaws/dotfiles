## Summary
Simple dotfiles.

## Setup 
1. Install [Brew](https://brew.sh)
1. Run `./setup.sh` to install dependencies via Brew
1. Setup Typescript development with `nvm install stable` and `npm -g install typescript typescript-language-server`
1. Open Neovim with `nvim`, things should bootstrap themselves

### Structure
The directory structure follows a normal `.config` setup.

#### Neovim config
Within the `nvim` config directory, you'll find the `init.lua` file that kicks off the bootstrapping process. It makes use of [lazy.nvim](https://github.com/folke/lazy.nvim) to bootstrap and install packages.
