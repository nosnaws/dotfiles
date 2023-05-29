(module dotfiles.plugin.lspconfig
  {autoload {util dotfiles.util
             nvim aniseed.nvim
             }}
  )

(defn- map [from to]
  (util.nnoremap from to)
  )

(let [(ok? lsp) (pcall require :lspconfig)]
  (when ok?
    (lsp.tsserver.setup {})
    (lsp.lua_ls.setup
      {:cmd ["lua-language-server"]
       :settings {:Lua {
                        :telemetry {:enable false}
                        :runtime { :version "LuaJIT"}
                        :diagnostics {:globals ["vim"]}
                        :workspace {:library (vim.api.nvim_get_runtime_file "" true)}
                        }}
       }
      )

    (map :gd "lua vim.lsp.buf.definition()")
    (map :gD "lua vim.lsp.buf.declaration()")
    (map :gr "lua vim.lsp.buf.references()")
    (map :gi "lua vim.lsp.buf.implementation()")
    (map :K "lua vim.lsp.buf.hover()")
    (map :<c-k> "lua vim.lsp.buf.signature_help()")

    (map :<leader>lr "lua vim.lsp.buf.rename()")
    (map :<leader>lf "lua vim.lsp.buf.format({async = true})")
    (map :<leader>ca "lua vim.lsp.buf.code_action()")
    )
  )
