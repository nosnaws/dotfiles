;;; lsp-config.el --- LSP mode configuration

(use-package lsp-mode
  :init
  (setq lsp-keymap-prefix "C-c l")
  :hook
  (lsp-mode . lsp-enable-which-key-integration)
  :custom
  (lsp-idle-delay 0.2)
  (lsp-log-io nil)
  (lsp-completion-provider :none)       ;; delegate completion to Corfu
  (lsp-enable-symbol-highlighting t)
  (lsp-headerline-breadcrumb-enable t)
  (lsp-signature-auto-activate t)
  (lsp-signature-render-documentation nil))

(use-package lsp-ui
  :after lsp-mode
  :custom
  (lsp-ui-doc-enable t)
  (lsp-ui-doc-position 'at-point)
  (lsp-ui-doc-show-with-cursor nil)     ;; show on hover, not always
  (lsp-ui-doc-show-with-mouse t)
  (lsp-ui-sideline-enable t)
  (lsp-ui-sideline-show-diagnostics t)
  (lsp-ui-sideline-show-code-actions t)
  (lsp-ui-sideline-show-hover nil))

(provide 'lsp-config)
