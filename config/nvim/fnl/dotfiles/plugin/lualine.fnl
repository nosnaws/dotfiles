(let [(ok? lualine) (pcall require :lualine)]
  (when ok?
    (lualine.setup {:options {:theme :iceberg }})))

