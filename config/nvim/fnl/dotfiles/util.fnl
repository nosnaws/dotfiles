(fn get [tbl key]
  "Gets a value out of a table, return nil if the table or value does not exist."
  (if tbl
      (. tbl key)))

(fn nnoremap [from to opts]
  (let [map-opts {:noremap true}
        to (.. ":" to "<cr>")]
    (if (get opts :local?)
      (vim.buf_keymap.set 0 :n from to map-opts)
      (vim.keymap.set :n from to map-opts))))

(fn lnnoremap [from to]
  (nnoremap (.. "<leader>" from) to))

(fn table? [x]
  "True if the value is of type 'table'."
  (= "table" (type x)))

(fn keys [t]
  "Get all the keys of a table."
  (let [result []]
    (when t
      (each [k _ (pairs t)]
        (table.insert result k)))
    result))

(fn count [xs]
  (if
    (table? xs) (let [maxn (table.maxn xs)]
                  ;; We only count the keys if maxn returns 0. TODO: why?
                  (if (= 0 maxn)
                      (table.maxn (keys xs))
                      maxn))
    (not xs) 0
    (length xs)))

(fn setopt [thing to]
  (tset vim.opt thing to))

(fn getopt [thing]
   (. (get vim.opt thing) "_value"))

{
  :nnoremap nnoremap 
  :lnnoremap lnnoremap 
  :count count 
  :get get 
  :setopt setopt
  :getopt getopt
}
