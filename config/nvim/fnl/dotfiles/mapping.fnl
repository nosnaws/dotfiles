(module dotfiles.mapping
  {autoload {nvim aniseed.nvim
             nu aniseed.nvim.util
             util dotfiles.util
             core aniseed.core}})

(defn- noremap [mode from to]
  "Sets a mapping with {:noremap true}."
  (nvim.set_keymap mode from to {:noremap true}))

;; Generic mappings
(nvim.set_keymap :n :<space> :<nop> {:noremap true})
(set nvim.g.mapleader " ")
(set nvim.g.maplocalleader ",")

;; Trying out the JK escape sequence
(noremap :i :jk :<esc>)
(noremap :c :jk :<c-c>)
(noremap :t :jk :<c-\><c-n>)

(util.lnnoremap :fs :w)
(util.lnnoremap :wq :q)














