(fn setopt [thing to]
  (tset vim.opt thing to))

;; Top level configuration for Neovim
(setopt :termguicolors true)
(setopt :background :dark)
(setopt :timeoutlen 1000)

;;(nvim.ex.setopt :spell)
(setopt :number true)
(setopt :wildmenu true)
(setopt :syntax :enable)
(setopt :cursorline true)
(setopt :lazyredraw true)
(setopt :showmatch true)
(setopt :incsearch true)
(setopt :confirm true)
(setopt :foldenable true)
(setopt :swapfile false)
(setopt :splitright true)
(setopt :splitbelow true)
(setopt :expandtab true)
(setopt :shiftwidth 2)


;; Color scheme
(vim.cmd (.. "colorscheme " "iceberg"))

