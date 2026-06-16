;;; completion.el --- Vertico stack + Corfu + Yasnippet

;;; Vertico — vertical minibuffer completion
(use-package vertico
  :init
  (vertico-mode))

;;; Orderless — flexible/fuzzy matching style
(use-package orderless
  :custom
  (completion-styles '(orderless basic))
  (completion-category-overrides '((file (styles basic partial-completion)))))

;;; Consult — enhanced search and navigation commands
(use-package consult
  :bind
  ("C-x b"   . consult-buffer)
  ("M-y"     . consult-yank-pop)
  ("C-s"     . consult-line)
  :custom
  (consult-preview-key '(:debounce 0.2 any))
  (consult-ripgrep-args
   "rg --null --line-buffered --color=never --max-columns=1000 --path-separator / --smart-case --no-heading --with-filename --line-number --search-zip --hidden --glob=!.git/"))

;;; Marginalia — annotations in the minibuffer (type, docstring, etc.)
(use-package marginalia
  :init
  (marginalia-mode))

;;; Corfu — in-buffer completion popup
(use-package corfu
  :custom
  (corfu-auto t)
  (corfu-auto-delay 0.2)
  (corfu-auto-prefix 2)
  (corfu-quit-no-match 'separator)
  (corfu-preselect 'prompt)
  :init
  (global-corfu-mode)
  (corfu-popupinfo-mode))  ;; show docs alongside completion popup

;;; Cape — extra completion-at-point sources for Corfu
(use-package cape
  :init
  (add-to-list 'completion-at-point-functions #'cape-dabbrev)
  (add-to-list 'completion-at-point-functions #'cape-file))

;;; Yasnippet — template/snippet expansion (also feeds LSP snippet completions)
(use-package yasnippet
  :hook (prog-mode . yas-minor-mode)
  :config
  (yas-reload-all))

(use-package yasnippet-snippets
  :after yasnippet)

(provide 'completion)
