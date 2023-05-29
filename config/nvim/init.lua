-- Entry point for Neovim config
--

local execute = vim.api.nvim_command
local fn = vim.fn

local pack_path = fn.stdpath("data") .. "/site/pack"
local fmt = string.format

local function ensure(user, repo)
  -- Ensure a given package is properly cloned in pack/packer/start dir
  local install_path = fmt("%s/packer/start/%s", pack_path, repo)
  if fn.empty(fn.glob(install_path)) > 0 then
    execute(fmt("!git clone https://github.com/%s/%s %s", user, repo, install_path))
    execute(fmt("packadd %s", repo))
  end
end

-- Bootstrap stuff
ensure("wbthomason", "packer.nvim")
ensure("rktjmp", "hotpot.nvim")

-- Load impatient which pre-compiles and caches lua modules.
vim.loader.enable()

-- Enable fennel (.fnl) support
require("hotpot")

-- Load config
require("dotfiles")
