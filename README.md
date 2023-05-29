> "I don't know what I'm doing"
> - Me (probably)

## Summary
My attempt to learn lisp, delve a bit deeper into my Neovim configuration, and finally make my dotfiles reproducible. __Heavily__ inspired by [Olical's dotfiles](https://github.com/Olical/dotfiles).

Some key things:
1. The setup script can be run with `./setup.sh`, it will install basic dependencies and create symlinks. Currently it only supports the `pacman` and `brew` package managers. 
2. Neovim can be run with the normal `nvim` command, it will boostrap it's own dependencies and compile the Fennel code down to lua automatically.
3. You're good to go!


### Structure
The directory structure follows a normal `.config` setup.

#### Neovim config
Within the `nvim` config directory, you'll find the `init.lua` file that kicks off the bootstrapping process. It makes use of `packer` for package management and `hotpot.nvim` for automatic Fennel compilation. After that the rest of the config can be found in `fnl/dotfiles`.
