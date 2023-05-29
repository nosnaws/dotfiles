(module dotfiles.core
  {autoload {nvim aniseed.nvim}})


;; Top level configuration for Neovim
(set nvim.o.termguicolors true)
(set nvim.o.background :dark)
(set nvim.o.timeoutlen 1000)

;;(nvim.ex.set :spell)
(nvim.ex.set :number)
(nvim.ex.set :wildmenu)
(nvim.ex.set "syntax=enable")
(nvim.ex.set :cursorline)
(nvim.ex.set :lazyredraw)
(nvim.ex.set :showmatch)
(nvim.ex.set :incsearch)
(nvim.ex.set :confirm)
(nvim.ex.set :foldenable)
(nvim.ex.set :noswapfile)
(nvim.ex.set :splitright)
(nvim.ex.set :splitbelow)
(nvim.ex.set :expandtab)
(nvim.ex.set "shiftwidth=2")
(nvim.ex.filetype :indent :on)


;; Color scheme
(nvim.ex.colorscheme :iceberg)


