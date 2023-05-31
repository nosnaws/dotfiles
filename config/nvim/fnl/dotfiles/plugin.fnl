(local util (require :dotfiles.util))
(local packer (require :packer))


(fn safe-require-plugin-config [name]
  (let [(ok? val-or-err) (pcall require (.. :dotfiles.plugin. name))]
    (when (not ok?)
      (print (.. "dotfiles error: " val-or-err)))))

(fn use [...]
  "Iterates through the arguments as pairs and calls packer's use function for
  each of them. Works around Fennel not liking mixed associative and sequential
  tables as well."
  (let [pkgs [...]]
    (packer.startup
      (fn [use]
        (for [i 1 (util.count pkgs) 2]
          (let [name (. pkgs i)
                opts (. pkgs (+ i 1))]
            (if (util.get opts :mod) (safe-require-plugin-config (util.get opts :mod)))
            (use {
                 1 name 
                 :requires (util.get opts :requires)
                 :startup (util.get opts :startup)
                 :update (util.get opts :update)
                 }))))))
  nil)
    
;; Plugin to be managed by packer.
(use
    :Olical/conjure {}
    :rktjmp/hotpot.nvim {}
    :kovisoft/paredit {}
    :cocopon/iceberg.vim {}
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
