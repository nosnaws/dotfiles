(module dotfiles.plugin.commenter
  {autoload {nvim aniseed.nvim}}
  )

(let [(ok? comm) (pcall require :Comment)]
  (when ok? 
    (comm.setup {}))
  )
