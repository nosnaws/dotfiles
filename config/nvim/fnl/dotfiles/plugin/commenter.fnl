(let [(ok? comm) (pcall require :Comment)]
  (when ok? 
    (comm.setup {}))
  )
