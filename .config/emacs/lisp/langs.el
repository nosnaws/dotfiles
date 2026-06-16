;;; langs.el --- Language-specific configuration

;;; treesit-auto — automatically use tree-sitter modes when grammars are available
(use-package treesit-auto
  :custom
  (treesit-auto-install 'prompt)
  :config
  (treesit-auto-add-to-auto-mode-alist 'all)
  (global-treesit-auto-mode))

;;; Go
(use-package go-mode
  :hook
  (go-mode    . lsp-deferred)
  (go-ts-mode . lsp-deferred))

(defun alec/go-before-save ()
  (lsp-format-buffer)
  (lsp-organize-imports))

(add-hook 'go-mode-hook
          (lambda () (add-hook 'before-save-hook #'alec/go-before-save nil t)))
(add-hook 'go-ts-mode-hook
          (lambda () (add-hook 'before-save-hook #'alec/go-before-save nil t)))

;;; TypeScript / TSX — treesit-auto routes .ts/.tsx to the built-in ts modes
(add-hook 'typescript-ts-mode-hook #'lsp-deferred)
(add-hook 'tsx-ts-mode-hook        #'lsp-deferred)

;;; Python — lsp-mode has no built-in pyright client; lsp-pyright provides it
(use-package lsp-pyright
  :custom (lsp-pyright-langserver-command "pyright")
  :hook
  (python-mode    . (lambda () (require 'lsp-pyright) (lsp-deferred)))
  (python-ts-mode . (lambda () (require 'lsp-pyright) (lsp-deferred))))

;;; Bash
(add-hook 'sh-mode-hook        #'lsp-deferred)
(add-hook 'bash-ts-mode-hook   #'lsp-deferred)

;;; YAML
(use-package yaml-mode
  :mode "\\.ya?ml\\'")

;;; TOML
(use-package toml-mode
  :mode "\\.toml\\'")

;;; JSON — treesit-auto will prefer json-ts-mode; json-mode is the fallback
(use-package json-mode)

(provide 'langs)
