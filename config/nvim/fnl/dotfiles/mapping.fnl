(local util (require :dotfiles.util))

(fn noremap [mode from to]
  "Sets a mapping with {:noremap true}."
  (vim.keymap.set mode from to {:noremap true}))

(fn toggle_bg []
  (if (= (util.getopt :background) :dark)
      (util.setopt :background :light)
      (util.setopt :background :dark)))

;; Generic mappings
(noremap :n :<space> :<nop>)
(set vim.g.mapleader " ")
(set vim.g.maplocalleader ",")

;; Trying out the JK escape sequence
(noremap :i :jk :<esc>)
(noremap :c :jk :<c-c>)
(noremap :t :jk :<c-\><c-n>)

(util.lnnoremap :fs :w)
(util.lnnoremap :wq :q)

(util.lnnoremap :pl "!npm run lint")
(util.lnnoremap :pt "!npm test")

(util.lnnoremap :11 "lua Dotfiles.toggle_bg()")

{:toggle_bg toggle_bg}











