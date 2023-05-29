(local util (require :dotfiles.util))

(fn noremap [mode from to]
  "Sets a mapping with {:noremap true}."
  (vim.keymap.set mode from to {:noremap true}))

;; Generic mappings
;;(nvim.set_keymap :n :<space> :<nop> {:noremap true})
(noremap :n :<space> :<nop>)
(set vim.g.mapleader " ")
(set vim.g.maplocalleader ",")

;; Trying out the JK escape sequence
(noremap :i :jk :<esc>)
(noremap :c :jk :<c-c>)
(noremap :t :jk :<c-\><c-n>)

(util.lnnoremap :fs :w)
(util.lnnoremap :wq :q)














