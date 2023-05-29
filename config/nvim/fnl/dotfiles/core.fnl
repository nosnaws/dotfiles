(local u (require :dotfiles.util))

;; Top level configuration for Neovim
(u.setopt :termguicolors true)
(u.setopt :background :dark)
(u.setopt :timeoutlen 500)

;;(nvim.ex.setopt :spell)
(u.setopt :number true)
(u.setopt :wildmenu true)
(u.setopt :syntax :enable)
(u.setopt :cursorline true)
(u.setopt :lazyredraw true)
(u.setopt :showmatch true)
(u.setopt :incsearch true)
(u.setopt :confirm true)
(u.setopt :foldenable true)
(u.setopt :swapfile false)
(u.setopt :splitright true)
(u.setopt :splitbelow true)
(u.setopt :expandtab true)
(u.setopt :shiftwidth 2)


;; Color scheme
(vim.cmd (.. "colorscheme " "iceberg"))

