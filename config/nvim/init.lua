-- Entry point for Neovim config
--

local ensure = function(user, repo)
  local fn = vim.fn
  local fmt = string.format
  local cmd = vim.api.nvim_command
  local install_path = fn.stdpath('data') .. fmt('/site/pack/packer/start/%s', repo)

  if fn.empty(fn.glob(install_path)) > 0 then
    cmd(fmt("!git clone --depth 1 https://github.com/%s/%s %s", user, repo, install_path))
    cmd(fmt("packadd %s", repo))
  end
end

-- Packages needed for bootstrapping
-- package manager
ensure('wbthomason', 'packer.nvim')
-- fennel compiler
ensure('rktjmp', 'hotpot.nvim')

-- Speeds things up?
vim.loader.enable()

-- Compile before we do anything else
require('hotpot')

-- Load config
-- Create global so that functions can be used in key bindings
Dotfiles = require("dotfiles")
