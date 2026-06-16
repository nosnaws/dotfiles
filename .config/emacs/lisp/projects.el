;;; projects.el --- Projectile, Dired, and Magit

;;; Projectile — project awareness and navigation
(use-package projectile
  :init
  (projectile-mode +1)
  :custom
  (projectile-completion-system 'auto)
  (projectile-sort-order 'recentf)
  (projectile-indexing-method 'alien))

(use-package consult-projectile
  :after (consult projectile))

;;; Dired — built-in file browser
(use-package dired
  :straight nil
  :hook (dired-mode . dired-hide-details-mode)
  :custom
  (dired-listing-switches "-ahl --group-directories-first")
  (dired-kill-when-opening-new-dired-buffer t)  ;; no buffer proliferation
  (dired-dwim-target t)                         ;; smart copy/move target
  :config
  ;; macOS ships BSD ls which doesn't support --group-directories-first
  ;; use GNU ls from coreutils (brew install coreutils) instead
  (when (eq system-type 'darwin)
    (setq insert-directory-program "gls")))

(use-package dired-x
  :straight nil
  :after dired)  ;; provides dired-jump (SPC o d)

(use-package dired-subtree
  :after dired
  :bind (:map dired-mode-map
              ("<tab>"     . dired-subtree-toggle)
              ("<backtab>" . dired-subtree-cycle)))

;;; Magit
(use-package magit
  :commands magit-status)

(provide 'projects)
