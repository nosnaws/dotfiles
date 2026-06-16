;;; core.el --- Evil, keybindings, and core utilities

;;; Undo — better undo tree for Evil
(use-package undo-fu)

(use-package undo-fu-session
  :config
  (undo-fu-session-global-mode))

;;; Evil
(use-package evil
  :init
  (setq evil-want-integration t
        evil-want-keybinding nil      ;; required before evil-collection loads
        evil-want-C-u-scroll t
        evil-want-C-i-jump nil
        evil-undo-system 'undo-fu
        evil-respect-visual-line-mode t
        evil-split-window-below t
        evil-vsplit-window-right t)
  :config
  (evil-mode 1))

(use-package evil-collection
  :after evil
  :config
  (evil-collection-init))

(use-package evil-surround
  :after evil
  :config
  (global-evil-surround-mode 1))

(use-package evil-commentary
  :after evil
  :config
  (evil-commentary-mode))

;;; jk to escape insert mode
(use-package evil-escape
  :after evil
  :custom
  (evil-escape-key-sequence "jk")
  (evil-escape-delay 0.2)
  :config
  (evil-escape-mode))

;;; Which-key
(use-package which-key
  :config
  (which-key-mode)
  (setq which-key-idle-delay 0.3
        which-key-sort-order 'which-key-key-order-alpha))

;;; Improved help buffers
(use-package helpful
  :bind
  ([remap describe-function] . helpful-callable)
  ([remap describe-variable] . helpful-variable)
  ([remap describe-key]      . helpful-key)
  ([remap describe-command]  . helpful-command))

;;; Leader keybindings (SPC, Doom-style)
(use-package general
  :after evil
  :config
  (general-evil-setup t)

  (general-create-definer leader!
    :states '(normal visual emacs)
    :keymaps 'override
    :prefix "SPC")

  (leader!
    ;; Top level
    "SPC" '(execute-extended-command :which-key "M-x")
    ":"   '(eval-expression           :which-key "eval")

    ;; Files
    "f"   '(:ignore t              :which-key "file")
    "f f" '(find-file              :which-key "find file")
    "f r" '(consult-recent-file    :which-key "recent files")
    "f s" '(save-buffer            :which-key "save")
    "f e" '((lambda () (interactive) (dired user-emacs-directory))
            :which-key "emacs config")

    ;; Buffers
    "b"   '(:ignore t              :which-key "buffer")
    "b b" '(consult-buffer         :which-key "switch")
    "b k" '(kill-current-buffer    :which-key "kill")
    "b n" '(next-buffer            :which-key "next")
    "b p" '(previous-buffer        :which-key "prev")

    ;; Windows
    "w"   '(:ignore t              :which-key "window")
    "w v" '(split-window-right     :which-key "split right")
    "w s" '(split-window-below     :which-key "split below")
    "w d" '(delete-window          :which-key "close")
    "w o" '(delete-other-windows   :which-key "only")
    "w h" '(evil-window-left       :which-key "←")
    "w l" '(evil-window-right      :which-key "→")
    "w j" '(evil-window-down       :which-key "↓")
    "w k" '(evil-window-up         :which-key "↑")

    ;; Search
    "s"   '(:ignore t              :which-key "search")
    "s s" '(consult-line           :which-key "in buffer")
    "s r" '(consult-ripgrep        :which-key "ripgrep")

    ;; Git
    "g"   '(:ignore t              :which-key "git")
    "g g" '(magit-status           :which-key "magit")
    "g b" '(magit-blame            :which-key "blame")

    ;; Project
    "p"   '(:ignore t                    :which-key "project")
    "p p" '(consult-projectile-switch-project :which-key "switch")
    "p f" '(consult-projectile-find-file      :which-key "find file")
    "p s" '(consult-ripgrep              :which-key "search")
    "p k" '(projectile-kill-buffers      :which-key "kill buffers")

    ;; Open
    "o"   '(:ignore t              :which-key "open")
    "o d" '(dired-jump             :which-key "dired")

    ;; Help
    "h"   '(:ignore t              :which-key "help")
    "h f" '(helpful-callable       :which-key "function")
    "h v" '(helpful-variable       :which-key "variable")
    "h k" '(helpful-key            :which-key "key")
    "h m" '(describe-mode          :which-key "mode")

    ;; LSP
    "l"   '(:ignore t              :which-key "lsp")
    "l r" '(lsp-rename             :which-key "rename")
    "l a" '(lsp-execute-code-action :which-key "code action")
    "l d" '(lsp-find-definition    :which-key "definition")
    "l R" '(lsp-find-references    :which-key "references")
    "l i" '(lsp-goto-implementation :which-key "implementation")
    "l f" '(lsp-format-buffer      :which-key "format")

    ;; Notes
    "n"   '(:ignore t              :which-key "notes")
    "n f" '(find-file              :which-key "find org file")

    ;; AI
    "a"   '(:ignore t              :which-key "AI")

    ;; Quit
    "q"   '(:ignore t              :which-key "quit")
    "q q" '(save-buffers-kill-emacs :which-key "quit")))

(provide 'core)
