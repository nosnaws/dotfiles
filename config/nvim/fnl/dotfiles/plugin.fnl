(module dotfiles.plugin
  {autoload {nvim aniseed.nvim
             a aniseed.core
             util dotfiles.util
             : packer}})

(defn safe-require-plugin-config [name]
  (let [(ok? val-or-err) (pcall require (.. :dotfiles.plugin. name))]
    (when (not ok?)
      (print (.. "dotfiles error: " val-or-err)))))

(defn use [...]
  "Iterates through the arguments as pairs and calls packer's use function for
  each of them. Works around Fennel not liking mixed associative and sequential
  tables as well."
  (let [pkgs [...]]
    (packer.startup
                    (fn [use]
                      (for [i 1 (a.count pkgs) 2]
                        (let [name (. pkgs i)
                              opts (. pkgs (+ i 1))]
                          (-?> (. opts :mod) (safe-require-plugin-config))
                          (use (a.assoc opts 1 name)))))))
  nil)
    
;; Plugin to be managed by packer.
(use
    :Olical/conjure {}
    :Olical/aniseed {}
    :kovisoft/paredit {}
    :cocopon/iceberg.vim {:mod :iceberg}
    :nvim-telescope/telescope.nvim {:mod :telescope :requires [[:nvim-lua/popup.nvim] [:nvim-lua/plenary.nvim]]}
    :nvim-treesitter/nvim-treesitter {:mod :treesitter}
    :neovim/nvim-lspconfig {:mod :lspconfig}
    :hrsh7th/cmp-buffer {}
    :hrsh7th/cmp-cmdline {}
    :hrsh7th/cmp-nvim-lsp {}
    :hrsh7th/cmp-path {}
    :hrsh7th/nvim-cmp {:mod :cmp}
    :wbthomason/packer.nvim {}
    :prettier/vim-prettier {}
    :numToStr/Comment.nvim {:mod :commenter}
    :folke/which-key.nvim {:mod :which-key}
    :nvim-lualine/lualine.nvim {:mod :lualine :requires [[:nvim-tree/nvim-web-devicons]]}
    :tpope/vim-fugitive {:mod :fugitive}
    )
